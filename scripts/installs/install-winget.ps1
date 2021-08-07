
$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'

Function space {
  Write-Host " "
}

Function print($text) {
  Write-Host $text
}

space
if (Get-Command winget) {
  print "WinGet is already installed on this device."
  exit
}

print "Preparing download..."
# Create new folder and set location.
if (!(Test-Path WinRice)) {
  New-Item WinRice -ItemType Directory | out-Null
  $currentdir = $(Get-Location).Path
  $dir = "$currentdir/WinRice"
  Set-Location $dir
}
else {
  Set-Location WinRice
}

# Download the packages.
$WinGetURL = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
print "Downloading WinGet installation packages..."
Start-BitsTransfer $WinGetURL.assets.browser_download_url;

if (!(Get-AppxPackage "Microsoft.VCLibs.*.UWPDesktop")) {
  $VCLibs = "Microsoft.VCLibs.140.00.UWPDesktop_14.0.30035.0_x64__8wekyb3d8bbwe.Appx"
  Start-BitsTransfer $VCLibs
  Add-AppxPackage Microsoft.VCLibs.140.00.UWPDesktop_14.0.30035.0_x64__8wekyb3d8bbwe.Appx
}

# Install WinGet.
print "Installing WinGet..."
Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

# Cleanup installers.
Set-Location ..
Remove-Item WinRice -Recurse -Force

# Get-Command winget, if it works then print success message.
if (Get-Command winget) {
  print "Installed WinGet."
}
else {
  print "WinGet could not be installed."
}
