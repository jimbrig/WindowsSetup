# Windows Setup 💻

> Suite of a variety of useful tools and scripts bundled as a PowerShell Module for setting up and customizing an optimal environment for a machine running on Windows 10 or 11.

## Desired Features

The desired outcome of this module is to provide support for the following features related to setting up and configuring Windows:

- Windows System Settings
- Network Settings
- Explorer Settings
- User Profiles and Folders
- System Drivers
- Creating ISO Images and Virtual Hard Disks (.vhdx)
- Hyper-V and VMs
- Credentials and Secrets Management:

This setup guide incorporates the following areas into the setup & configuration of Windows:

- Windows Settings
  - Windows Update Settings
    - (Optional) Activation of Windows Insider Preview
    - Automation of downloading and installing the latest Windows updates
    - Ability to troubleshoot and reset Windows Update related services and settings (DISM, WSUS, BITS, Registry Entries, Restore Points, SFC, Winsock)
  - System Settings
    - Power Plan Configuration (pwrcfg)
      - Enable High Performance Power Plans
      - Ability to create, backup, and restore custom Power Plans
    - Display and Sound:
      - Setup Monitors, Brightness, Night Light, and Display Profile
    - Storage:
      - Activate and Configure Storage Sense
- Explorer Settings
- Optional Features
- User Profiles
- Drivers
- ISO Images
- Hyper-V & virtual Machines
- Credentials and Secrets
  - Windows Credential Manager Online and Windows credential stores
  - GPG Keys
  - SSH Keys
  - Software License Keys
  - Windows 10 Pro Activation License Key
  - Office365/Microsoft365 Activation License Key
  - API Keys
- Environment Variables
- Scripts
  - Batch Files
  - PowerShell Scripts
  - R Scripts
  - Bash Scripts
  - etc.
- Installations
  - Package Managers
    - WinGet
    - Chocolatey
    - Scoop
  - System Wide (All Users) Software
  - User Software
  - Manual Executable Installations


## Contents

## Installation

### System Updates

- Settings > Update & Security > Install all Updates

### PowerShell Execution Policy

```powershell
Set-ExecutionPolicy Unrestricted
```

### WinGet Installs

```powershell
winget install PowerShell-Preview
winget install git
git config --global user.name "Jimmy Briggs"
git config --global user.email "jimbrig1993@outlook.com"
winget install RProject.R RStudio.RStudio RProject.Rtools
winget install vscode-insiders
winget install SumatraPDF
winget install autohotkey

## Visual Studio Build Tool
## https://visualstudio.microsoft.com/fr/visual-cpp-build-tools/
## /!\ VERY LONG INSTALLATION /!\
winget install Microsoft.VisualStudio.BuildTools

# install scoop
iwr -useb get.scoop.sh | iex
scoop checkup
scoop install 7zip
scoop install aria2
scoop install innounp
scoop install dark
scoop install sudo

sudo Add-MpPreference -ExclusionPath '%HOMEPATH%\scoop'
sudo Add-MpPreference -ExclusionPath 'C:\ProgramData\scoop'
sudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

# installed with scoop
scoop bucket add extras
scoop install keypirinha
keypirinha.exe
scoop install pandoc
scoop install pandoc-crossref
scoop install everything
scoop install hugo-extended
scoop install jq
scoop install ffmpeg
scoop install gifski
scoop install screentogif
scoop install joplin
scoop install optipng

# Prefer Oh My Posh
# scoop install pshazz
# sudo Set-Service ssh-agent -StartupType Manual
# scoop install concfg
# concfg export console-backup.json
# concfg import solarized-dark

scoop install aria2
scoop install nano

scoop install gh
# add autocompletion
Add-Content -Path (echo $profile) -Value 'try { $null = gcm gh -ea stop; Invoke-Expression -Command $(gh completion -s powershell | Out-String) } catch { }'

scoop install bit
# add autocompletion
bit complete

scoop install bat
scoop install less
scoop install tldr

## Rust
scoop install rust-msvc

## Nodejs
scoop install nodejs
npm install -g gitmoji-cli
npm install -g standard

scoop install rtools

# Fonts
scoop bucket add nerd-fonts
sudo scoop install FiraCode
sudo scoop install FiraCode-NF
sudo scoop Cascadia-Code

# Configure powershell
## Powerline setup https://docs.microsoft.com/en-us/windows/terminal/tutorials/powerline-setup
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

Set-PowerLinePrompt -PowerLineFont
Add-Content -Path (echo $PROFILE) -Value '# Powerline setup'
Add-Content -Path (echo $PROFILE) -Value 'Import-Module posh-git'
Add-Content -Path (echo $PROFILE) -Value 'Import-Module oh-my-posh'
Add-Content -Path (echo $PROFILE) -Value 'Set-Theme Paradox'

# Activate WSL
## * https://docs.microsoft.com/fr-fr/windows/wsl/install-win10)
## * https://support.rstudio.com/hc/en-us/articles/360049776974-Using-RStudio-Server-in-Windows-WSL2
sudo dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
## WSL 2
sudo dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
## restart
## update kernel : https://docs.microsoft.com/fr-fr/windows/wsl/wsl2-kernel
sudo wsl --set-default-version 2
## Install ubuntu from winstore and run it to install

## Share env var (https://devblogs.microsoft.com/commandline/share-environment-vars-between-wsl-and-windows/)
setx WSLENV
```
