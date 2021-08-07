Function Install-CommonPackages {
  <#
    .SYNOPSIS
    This function installs packages enumerated in configuration files.
    .DESCRIPTION
    This function in details:
    * takes a list of packages from configuration file,
    * skips packages marked as disabled,
    * installs each package left,
    * uses chocolatey package manager.
    .PARAMETER CfgFile
    Configuration file.
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-CommonPackages.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/chocolatey.psm1
    .LINK
    https://chocolatey.org/packages
#>
  Param ( [Parameter(Mandatory = $true)][String] $CfgFile )

  ( Get-Content $CfgFile | ConvertFrom-Json ).chocolatey.packages |
  Where-Object { -Not $_.disabled } |
  ForEach-Object {
    if ( $_.version ) {
      cinst --no-progress --limit-output --allow-empty-checksums -y $_.id --version $_.version
    }
    else {
      cinst --no-progress --limit-output --allow-empty-checksums -y $_.id
    }
  }
}
