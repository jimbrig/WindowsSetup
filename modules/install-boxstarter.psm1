Function Install-Boxstarter {
  <#
  .SYNOPSIS
  Installs Boxstarter for windows.
  .LINK
  https://boxstarter.org
  .EXAMPLE
  Install-Boxstarter
  #>

  Write-Info "Checking for boxstarter Installation..."
  if (Test-Command boxstarter) {
    Write-Success "BoxStarter installation detected; Skipping installation..."
  }
  else {
    Write-Failure "BoxStarter installation not detected; Installing..."
    Write-Task "Checking for Administrative Priveledges..."
    # Ensure Admin Priveledges
    if (!(Test-Admin)) {
      Write-Failure "Admin priveledges not detected; Starting new process/shell as admin to install boxstarter..."
      Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit
    }
    Write-Host ""
    Write-Host "Installing BoxStarter for Windows..." -ForegroundColor Green
    Write-Host "------------------------------------" -ForegroundColor Green
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://boxstarter.org/bootstrapper.ps1')); Get-Boxstarter -Force
    Write-Task "Updating Environment"
    Update-Environment
    if (Test-Command boxstarter) {
      Write-Success "Successfully installed boxstarter to system."
    }
    else {
      Write-Failure "Failed to install boxstarter..."
    }
  }
}




