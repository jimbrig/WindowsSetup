<#
    .SYNOPSIS
    Windows 10 Software packaging wrapper
    .DESCRIPTION
    Install:   PowerShell.exe -ExecutionPolicy Bypass -Command .\INSTALL-RSAT-Online.ps1 -install
    Uninstall: PowerShell.exe -ExecutionPolicy Bypass -Command .\INSTALL-RSAT-Online.ps1 -uninstall
    Detect:    PowerShell.exe -ExecutionPolicy Bypass -Command .\INSTALL-RSAT-Online.ps1 -detect
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
$logFile = ('{0}\{1}.log' -f "C:\Windows\Logs", [System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name))


if ($install) {
  Start-Transcript -path $logFile
  try {
    $InstallRSAT = Get-WindowsCapability -Online | Where-Object { $_.Name -like "Rsat*" -AND $_.State -eq "NotPresent" }
    if ($InstallRSAT -ne $null) {
      foreach ($Item in $InstallRSAT) {
        $RsatItem = $Item.Name
        Write-Verbose -Verbose "Adding $RsatItem to Windows"
        try {
          Add-WindowsCapability -Online -Name $RsatItem
        }
        catch [System.Exception] {
          Write-Verbose -Verbose "Failed to add $RsatItem to Windows"
          Write-Warning -Message $_.Exception.Message
        }
      }
    }
    else {
      Write-Verbose -Verbose "All RSAT features seems to be installed already"
    }
  }
  catch {
    $PSCmdlet.WriteError($_)
  }
  Stop-Transcript
}

if ($uninstall) {
  Start-Transcript -path $logFile
  try {
    $Uninstalled = Get-WindowsCapability -Online | Where-Object { $_.Name -like "Rsat*" -AND $_.State -eq "Installed" -AND $_.Name -notlike "Rsat.ServerManager*" -AND $_.Name -notlike "Rsat.GroupPolicy*" -AND $_.Name -notlike "Rsat.ActiveDirectory*" }
    if ($Uninstalled -ne $null) {
      foreach ($Item in $Uninstalled) {
        $RsatItem = $Item.Name
        Write-Verbose -Verbose "Uninstalling $RsatItem from Windows"
        try {
          Remove-WindowsCapability -Name $RsatItem -Online
        }
        catch [System.Exception] {
          Write-Verbose -Verbose "Failed to uninstall $RsatItem from Windows"
          Write-Warning -Message $_.Exception.Message
        }
      }
    }
  }
  catch {
    $PSCmdlet.WriteError($_)
  }
  Stop-Transcript
}

if ($detect) {
  Start-Transcript -path $logFile -Append
  try {
    $detection = "Detection not implemented yet..."

    return $detection
  }
  catch {
    $PSCmdlet.WriteError($_)
    return $false
  }
  Stop-Transcript
}
