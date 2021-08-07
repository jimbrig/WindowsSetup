<#
    .SYNOPSIS
    Windows 10 enable optional features
    .DESCRIPTION
    Install:   PowerShell.exe -ExecutionPolicy Bypass -Command .\INSTALL-WindowsSandbox.ps1 -install
    Uninstall: PowerShell.exe -ExecutionPolicy Bypass -Command .\INSTALL-WindowsSandbox.ps1 -uninstall
    Detect:    PowerShell.exe -ExecutionPolicy Bypass -Command .\INSTALL-WindowsSandbox.ps1 -detect
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory = $true, ParameterSetName = 'install')]
  [switch]$install,
  [Parameter(Mandatory = $true, ParameterSetName = 'uninstall')]
  [switch]$uninstall,
  [Parameter(Mandatory = $true, ParameterSetName = 'detect')]
  [switch]$detect
)

$ErrorActionPreference = "SilentlyContinue"
#Use "C:\Windows\Logs" for System Installs and "$env:TEMP" for User Installs
$logFile = ('{0}\{1}.log' -f "C:\Windows\Logs", [System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name))
$WindowsFeature = "Containers-DisposableClientVM"

if ($install) {
  Start-Transcript -path $logFile -Append

  try {
    #Get the state of the Windows Feature
    $WindowsFeatureState = (Get-WindowsOptionalFeature -FeatureName $WindowsFeature -Online).State
  }
  catch {
    Write-Error "Failed to get the state of $WindowsFeature"
  }

  #Verify if the Windows Feature is enabled
  if ($WindowsFeatureState -eq "Enabled") {
    Write-Output "$WindowsFeature is enabled"
  }
  else {
    try {
      #Enable the Windows Feature
      Enable-WindowsOptionalFeature -FeatureName $WindowsFeature -Online -NoRestart -ErrorAction Stop
      Write-Output "Successfully enabled $WindowsFeature"
    }
    catch {
      Write-Error "Failed to enable $WindowsFeature"
    }
  }

  Stop-Transcript
}

if ($uninstall) {
  Start-Transcript -path $logFile -Append
  try {
    Disable-WindowsOptionalFeature -FeatureName $WindowsFeature -Remove -NoRestart -ErrorAction Stop

    return $true
  }
  catch {
    $PSCmdlet.WriteError($_)
    return $false
  }
  Stop-Transcript
}

if ($detect) {
  Start-Transcript -path $logFile -Append
  try {
    #Get the state of the Windows Feature
    $WindowsFeatureState = (Get-WindowsOptionalFeature -FeatureName $WindowsFeature -Online).State

    if ($WindowsFeatureState -eq "Enabled") {
      return $true
    }
  }
  catch {
    $PSCmdlet.WriteError($_)
    return $false
  }
  Stop-Transcript
}
