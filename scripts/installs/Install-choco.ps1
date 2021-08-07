
# Ensure Admin Priveledges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }




if (Check-Command -cmdname 'choco') {
    Write-Host "Choco is already installed, skip installation."
}
else {
    Write-Host "Installing Chocolatey first..."
    Write-Host "------------------------------------"
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Host "Installed Chocolatey" -ForegroundColor Green
}
if (Check-Command -cmdname 'Install-BoxstarterPackage') {
    Write-Host "Boxstarter is already installed, skip installation."
}
else {
    Write-Host "Installing Boxstarter..."
    Write-Host "------------------------------------"
    . { Invoke-WebRequest -useb https://boxstarter.org/bootstrapper.ps1 } | Invoke-Expression; Get-Boxstarter -Force
    Write-Host "Installed Boxstarter" -ForegroundColor Green
}

Set-ExecutionPolicy Bypass -Scope Process -Force;

if (-not $env:ChocolateyInstall -or -not (Test-Path "$env:ChocolateyInstall")) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
