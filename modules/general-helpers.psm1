Function Test-Admin {
  <#
  .SYNOPSIS
  Tests for Administrative Priveledges
  .EXAMPLE
  Test-Admin
  .LINK
    https://github.com/jimbrig/Scripts/blob/main/PowerShell/Functions/general-helpers.ps1
  #>
  ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
}

# Test-Command
Function Test-Command {
  <#
  .SYNOPSIS
  Checks for a provided Command via `Get-Command`
  .PARAMETER cmdname
  Command Name to test for
  .EXAMPLE
  Test-Command choco
  .LINK
    https://github.com/jimbrig/Scripts/blob/main/PowerShell/Functions/general-helpers.ps1
  #>
  Param (
    [Parameter(Mandatory = $true)][String] $cmdname
  )
  return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

Function Get-EnvironmentVariable {
  <#
  .SYNOPSIS
  Gets an Environment Variable.
  .DESCRIPTION
  This will will get an environment variable based on the variable name
  and scope while accounting whether to expand the variable or not
  (e.g.: `%TEMP%`-> `C:\User\Username\AppData\Local\Temp`).
  .NOTES
  This helper reduces the number of lines one would have to write to get
  environment variables, mainly when not expanding the variables is a
  must.
  .PARAMETER Name
  The environment variable you want to get the value from.
  .PARAMETER Scope
  The environment variable target scope. This is `Process`, `User`, or
  `Machine`.
  .PARAMETER PreserveVariables
  A switch parameter stating whether you want to expand the variables or
  not. Defaults to false. Available in 0.9.10+.
  .PARAMETER IgnoredArguments
  Allows splatting with arguments that do not apply. Do not use directly.
  .EXAMPLE
  Get-EnvironmentVariable -Name 'TEMP' -Scope User -PreserveVariables
  .EXAMPLE
  Get-EnvironmentVariable -Name 'PATH' -Scope Machine
  .LINK
  Get-EnvironmentVariableNames
  .LINK
  Set-EnvironmentVariable
  #>
  [CmdletBinding()]
  [OutputType([string])]
  param(
    [Parameter(Mandatory = $true)][string] $Name,
    [Parameter(Mandatory = $true)][System.EnvironmentVariableTarget] $Scope,
    [Parameter(Mandatory = $false)][switch] $PreserveVariables = $false,
    [parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
  )

  # Do not log function call, it may expose variable names
  ## Called from chocolateysetup.psm1 - wrap any Write-Host in try/catch

  [string] $MACHINE_ENVIRONMENT_REGISTRY_KEY_NAME = "SYSTEM\CurrentControlSet\Control\Session Manager\Environment\";
  [Microsoft.Win32.RegistryKey] $win32RegistryKey = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($MACHINE_ENVIRONMENT_REGISTRY_KEY_NAME)
  if ($Scope -eq [System.EnvironmentVariableTarget]::User) {
    [string] $USER_ENVIRONMENT_REGISTRY_KEY_NAME = "Environment";
    [Microsoft.Win32.RegistryKey] $win32RegistryKey = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey($USER_ENVIRONMENT_REGISTRY_KEY_NAME)
  }
  elseif ($Scope -eq [System.EnvironmentVariableTarget]::Process) {
    return [Environment]::GetEnvironmentVariable($Name, $Scope)
  }

  [Microsoft.Win32.RegistryValueOptions] $registryValueOptions = [Microsoft.Win32.RegistryValueOptions]::None

  if ($PreserveVariables) {
    Write-Verbose "Choosing not to expand environment names"
    $registryValueOptions = [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames
  }

  [string] $environmentVariableValue = [string]::Empty

  try {
    #Write-Verbose "Getting environment variable $Name"
    if ($null -ne $win32RegistryKey) {
      # Some versions of Windows do not have HKCU:\Environment
      $environmentVariableValue = $win32RegistryKey.GetValue($Name, [string]::Empty, $registryValueOptions)
    }
  }
  catch {
    Write-Debug "Unable to retrieve the $Name environment variable. Details: $_"
  }
  finally {
    if ($null -ne $win32RegistryKey) {
      $win32RegistryKey.Close()
    }
  }

  if ($null -eq $environmentVariableValue -or $environmentVariableValue -eq '') {
    $environmentVariableValue = [Environment]::GetEnvironmentVariable($Name, $Scope)
  }

  return $environmentVariableValue
}

Function Get-EnvironmentVariableNames([System.EnvironmentVariableTarget] $Scope) {
  <#
  .SYNOPSIS
  Gets all environment variable names.
  .DESCRIPTION
  Provides a list of environment variable names based on the scope. This
  can be used to loop through the list and generate names.
  .NOTES
  Process dumps the current environment variable names in memory /
  session. The other scopes refer to the registry values.
  .INPUTS
  None
  .OUTPUTS
  A list of environment variables names.
  .PARAMETER Scope
  The environment variable target scope. This is `Process`, `User`, or
  `Machine`.
  .EXAMPLE
  Get-EnvironmentVariableNames -Scope Machine
  .LINK
  Get-EnvironmentVariable
  .LINK
  Set-EnvironmentVariable
  #>

  # Do not log function call

  # HKCU:\Environment may not exist in all Windows OSes (such as Server Core).
  switch ($Scope) {
    'User' { Get-Item 'HKCU:\Environment' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Property }
    'Machine' { Get-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' | Select-Object -ExpandProperty Property }
    'Process' { Get-ChildItem Env:\ | Select-Object -ExpandProperty Key }
    default { throw "Unsupported environment scope: $Scope" }
  }
}

# Update-Environment / Refresh Environment Variables
Function Update-Environment {
  <#
  .SYNOPSIS
  Updates/Refreshes the Environment
  .DESCRIPTION
  When changes are not visible to the current PowerShell session, the user needs to open a new PowerShell session before these settings take effect.
  Use the Update-Environment command to refresh the current PowerShell session with all environment settings.
  .INPUTS
  None
  .OUTPUTS
  None
  .EXAMPLE
  Update-Environment
  .LINK
  https://github.com/jimbrig/Scripts/blob/main/PowerShell/Functions/general-helpers.ps1
  .LINK
  https://docs.chocolatey.org/en-us/create/functions/update-sessionenvironment
  #>

  Write-FunctionCallLog -Invocation $MyInvocation -Parameters $PSBoundParameters

  $refreshEnv = $false
  $invocation = $MyInvocation
  if ($invocation.InvocationName -eq 'refreshenv') {
    $refreshEnv = $true
  }

  if ($refreshEnv) {
    Write-Output 'Refreshing environment variables from the registry for powershell.exe. Please wait...'
  }
  else {
    Write-Verbose 'Refreshing environment variables from the registry.'
  }

  $userName = $env:USERNAME
  $architecture = $env:PROCESSOR_ARCHITECTURE
  $psModulePath = $env:PSModulePath

  #ordering is important here, $user should override $machine...
  $ScopeList = 'Process', 'Machine'
  if ($userName -notin 'SYSTEM', "${env:COMPUTERNAME}`$") {
    # but only if not running as the SYSTEM/machine in which case user can be ignored.
    $ScopeList += 'User'
  }
  foreach ($Scope in $ScopeList) {
    Get-EnvironmentVariableNames -Scope $Scope |
    ForEach-Object {
      Set-Item "Env:$_" -Value (Get-EnvironmentVariable -Scope $Scope -Name $_)
    }
  }

  #Path gets special treatment b/c it munges the two together
  $paths = 'Machine', 'User' |
  ForEach-Object {
    (Get-EnvironmentVariable -Name 'PATH' -Scope $_) -split ';'
  } |
  Select-Object -Unique
  $Env:PATH = $paths -join ';'

  # PSModulePath is almost always updated by process, so we want to preserve it.
  $env:PSModulePath = $psModulePath

  # reset user and architecture
  if ($userName) { $env:USERNAME = $userName; }
  if ($architecture) { $env:PROCESSOR_ARCHITECTURE = $architecture; }

  Write-Host "✔️ Sucessfully Refreshed Environment Variables..." -ForegroundColor Green
}

Function Take-Ownership {
  <#
  .SYNOPSIS
  Take Ownership over a file or folder.
  .NOTES
  This function requires the `sudo` package/command (i.e. scoop install sudo).
  .PARAMETER path
  Path to the file or folder to take ownership of.
  .EXAMPLE
  Take-Ownership "C:\Program Files\Windows Apps"
  #>
  param (
    [Parameter(Mandatory = $true)][String] $path
  )
  if ((Get-Item $path) -is [System.IO.DirectoryInfo]) {
    sudo takeown /r /d Y /f $path
  }
  else {
    sudo takeown /f $path
  }
}

function Force-Delete {
  <#
  .SYNOPSIS
  Force delete a file or folder by first taking ownership of it and then permanently deleting it.
  .PARAMETER path
  Path to file or folder to delete.
  .EXAMPLE
  Force-Delete C:\tmp\file.txt
  .NOTES
  This function depends on the sudo command (i.e. scoop install sudo)
  #>
  param (
    [Parameter(Mandatory = $true)][String] $path
  )
  Take-Ownership $path
  sudo remove-item -path $path -Force -Recurse -ErrorAction SilentlyContinue
  if (!(Test-Path $path)) {
    Write-Host "✔️ Successfully Removed $path" -ForegroundColor Green
  }
  else {
    Write-Host "❌ Failed to Remove $path" -ForegroundColor Red
  }
}

# function Add-PATH ( $addpath ) {
#   $environ = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
#   $environupdated = $Environment.Insert($Environment.Length, $addpath)
#   [System.Environment]::SetEnvironmentVariable("Path", $environupdated, "Machine")
# }


