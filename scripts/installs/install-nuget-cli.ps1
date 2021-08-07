$presentdir = Get-Location
Set-Location -Path "$presentdir\scripts\helpers"
. ".\load-all-helpers.ps1"
Set-Location $presentdir

Write-Begin "Downloading nuget-cli from URL: <https://dist.nuget.org/win-x86-commandline/latest/nuget.exe>"
$url = 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe'
Install-fromURL $url "nuget"
Write-Success "Successfully downloaded 'nuget.exe' into Downloads Folder."

If (!(Test-Path "C:\bin")) {
  mkdir "C:\bin"
}

Copy-Item -Path "~/Downloads/nuget.exe" -Destination "C:\bin"
sudo [Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\bin", "Machine")
Write-Success "Successfully copied nuget.exe to 'C:\bin and added to environment variable PATH"
Update-Environment

