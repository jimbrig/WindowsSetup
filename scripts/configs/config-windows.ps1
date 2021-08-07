# load feedback functions
. "../helpers/feedback-helpers.ps1"

Write-Begin 'Configuring Windows settings...'

Write-Task 'Disabling New Network wizard'
New-ItemProperty -Path HKLM:\System\CurrentControlSet\Control\Network -Name NewNetworkWindowOff -Value '1' -Force | Out-Null
Write-Success 'Successfully Disabled New Network Wizard'

Write-Task 'Disabling UAC'
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA -PropertyType DWORD -Value '0x0' -Force | Out-Null
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -PropertyType DWORD -Value '0x0' -Force | Out-Null
Write-Success 'Successfully Disabled UAC'

Write-Task 'Setting Power Plan to high performance'
C:\Windows\System32\powercfg.exe -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c | Out-Null
Write-Success 'Successfully Created and Enabled High Performance Power Plan'

Write-Task 'Disabling IE Enhanced Security Configuration'
Write-Info 'Once for Administrators, once for regular Users (yes, these are 2 different paths)'
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}' -Name IsInstalled -PropertyType DWORD -Value '0x0' -Force | Out-Null
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}' -Name IsInstalled -PropertyType DWORD -Value '0x0' -Force | Out-Null
Write-Success 'Successfully Edited Registry to Disable IE Enhanced Security Configurations'

Write-Task 'Enabling RDP'
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -PropertyType DWORD -Value '0x0' -Force | Out-Null
Write-Success 'Successfully Enabled RDP'

#Write-Verbose 'Disabling Page File'
#New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name PagingFiles -Value '' -Force | Out-Null

Write-Success 'Configuring Windows settings complete'

# Network Discovery
Invoke-Expression 'netsh advfirewall firewall set rule group=”network discovery” new enable=yes'

# File and Printer Sharing
Invoke-Expression 'netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=yes'
