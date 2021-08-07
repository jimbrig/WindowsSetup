# import functions and modules
Import-Module -Name .\winsetup.psd1 -Verbose

Write-Header "Provisioning Machine"
Write-Step "1" "System Configuration"

# --- Computer Name ---
$computerName = Read-Host 'Enter New Computer Name'
Write-Host "Renaming this computer to: " $computerName  -ForegroundColor Yellow
Rename-Computer -NewName $computerName
Write-Success "Computer successfully renamed to $computerName."

# --- Set Execution Policy to Unrestricted ---
# Note, this may need to be run BEFORE this script
Write-Info "Setting Execution Policy to Unrestricted for Current User..."
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force -ErrorAction Ignore
Write-Success "Successfully set unrestricted execution policy."

# --- Enable Developer Mode on the System ---
Write-Info "Enable Developer Mode on the System"
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1
Write-Success "Successfully Enabled Developer Mode. Refreshing Environment..."
Update-Environment

# --- Install Chocolatey and BoxStarter if not already installed ---
Install-Choco
Install-Boxstarter

# --- File Explorer Options ---
Write-Task "Configuring Explorer Options via boxstarter's winconfig module..."

# Show hidden files, Show protected OS files, Show file extensions
Write-Info "Show hidden files, Show protected OS files, Show file extensions"
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions
Write-Success "DONE"

Write-Task "Editing Registry to tweak explorer options..."

# Expand explorer to the actual folder you're in
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
# Add things back in your left pane like recycle bin
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
# Opens explorer to This PC, not quick access
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1

Write-Success "Configured file explorer options."

# --- Windows Features ---
Write-Task "Setup Windows Optional Features"



Write-Host "STEP 2 : Installing Applications" -ForegroundColor Yellow

# --- WINGET installs ---
winget install Microsoft.WindowsTerminal -e
winget install Microsoft.VisualStudioCode -e
winget install Git.Git --override /GitAndUnixToolsOnPath --override /WindowsTerminal -e
winget install GitHub.GitHubDesktop -e
winget install 7zip.7zip -e
winget install Microsoft.PowerToys -e
winget install Telerik.Fiddler -e
#winget install linqpad -e
#winget install WinMerge -e
winget install Microsoft.EdgeDev -e
winget install WhatsApp.WhatsApp -e
winget install Spotify.Spotify -e
# winget install skype -e # desktop
#winget install DockerDesktop -e
#winget install node -e
# winget install python
# winget install wsl
# winget install Microsoft.OneDrive

# --- additional configuration ---
# install visual studio components

# choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"

# other apps
# - utorrent
# - monogame sdk
# - Polar Flow

# store apps
# - heif
# - hevc
# - Microsoft To Do
# - Netflix
# - NextGen Reader
# - OneNote for Windows 10
# - Skype (Store app)
# - Xbox
# - Xbox Console Companion
# - Xbox Smartglass

# --- Install VS Code Extensions
Write-Host "STEP 3 : Configuring VS Code" -ForegroundColor Yellow
. .\vscode\vscode.ps1

Write-Host ".: Configuring VS Code Key Bindings ... " -NoNewline
Copy-Item ".\vscode\keybindings.json" -Destination "%UserProfile%\AppData\Roaming\Code\User\keybindings.json" -Force
Write-Host "DONE" -ForegroundColor Green
Write-Host ".: Configuring VS Code Settings ... " -NoNewline
Copy-Item ".\vscode\settings.json" -Destination "%UserProfile%\AppData\Roaming\Code\User\settings.json" -Force
Write-Host "DONE" -ForegroundColor Green

# --- Configure Windows Terminal / Powershell
Write-Host "STEP 4 : Configuring Windows Terminal" -ForegroundColor Yellow
. .\ohmyposh.ps1

# $option = New-BinaryMenu -Title 'Something' -Question 'Do you want to install X?'

# if ($option) {
# Write-Host "Recevied: " -NoNewline
# Write-Host $option
# }


Write-Host ".: Installing Visual Studio ... " -NoNewline
winget install Microsoft.VisualStudio.Community -e
Write-Host "DONE" -ForegroundColor Green
