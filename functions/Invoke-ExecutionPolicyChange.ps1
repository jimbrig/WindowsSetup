<#
    .SYNOPSIS
    Windows 10 configure PS ExecutionPolicy via TaskSequence
    .DESCRIPTION
    Install:   PowerShell.exe -ExecutionPolicy Bypass -Command .\Invoke-ExecutionPolicyChange.ps1 -policy AllSigned | Bypass | Default | RemoteSigned | Restricted | Undefined | Unrestricted
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory = $true, ParameterSetName = 'policy')]
  [ValidateSet('AllSigned', 'Bypass', 'Default', 'RemoteSigned', 'Restricted', 'Undefined', 'Unrestricted')]
  [string]
  $policy
)

$logFile = ('{0}\{1}.log' -f "C:\Windows\Logs", "W10_SetExecutionPolicy")
Start-Transcript -path $logFile
$ErrorActionPreference = 'Stop'

try {
  $registryPath = "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell"
  $Name = "ExecutionPolicy"

  New-ItemProperty -Path $registryPath -Name $name -Value $policy -PropertyType String -Force

  $CurrentPolicy = Get-ExecutionPolicy
  Write-Host "ExecutionPolicy is $CurrentPolicy"
}
catch {
  $PSCmdlet.WriteError($_)
}

Stop-Transcript
