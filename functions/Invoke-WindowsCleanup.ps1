<#
    .SYNOPSIS
    Windows 10 Software packaging wrapper
    .DESCRIPTION
    Install:   PowerShell.exe -ExecutionPolicy Bypass -Command .\Invoke-WindowsCleanup.ps1
    .AUTHOR
    Jimmy Briggs
#>

$logFile = ('{0}\{1}.log' -f "C:\Windows\Logs", [System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name))
Start-Transcript -path $logFile

#Check if the script run with administrator privilege
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  $arguments = "& '" + $myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

#Windows.old path
$path = $env:HOMEDRIVE + "\windows.old"
If (Test-Path -Path $path) {
  #create registry value
  $regpath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Previous Installations"
  New-ItemProperty -Path $regpath -Name "StateFlags1221" -PropertyType DWORD  -Value 2 -Force  | Out-Null
  #start clean application
  cleanmgr /SAGERUN:1221
}
Else {
  Write-Warning "There is no 'Windows.old' folder in system driver"
  cmd /c pause
}
Stop-Transcript
