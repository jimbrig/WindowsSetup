$providers = @(
  'NuGet',
  'PowerShellGet',
  'ChocolateyGet',
  'Chocolatey'
)

Write-Host 'Installing package providers:'
$providers | ForEach-Object {
  Write-Host "-> $_"
  Install-PackageProvider $_ -Force
}

Write-Host ''
