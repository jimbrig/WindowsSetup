Function Install-VisualStudioCodeExtensions {
  <#
    .SYNOPSIS
    This function installs Visual Studio Code Extensions enumerated in configuration file.
    .DESCRIPTION
    This function in details:
    * takes a Visual Studio Code extensions list to install from configuration file,
    * skips extensions marked as disabled,
    * executes VS Code to install all extensions left.
    .PARAMETER CfgFile
    Configuration file.
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudioCodeExtensions.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/vscode.psm1
#>
  Param ( [Parameter(Mandatory = $true)][String] $CfgFile )

  ( Get-Content $CfgFile | ConvertFrom-Json ).vscode.extensions |
  Where-Object { -Not $_.disabled } |
  ForEach-Object { code --install-extension $_.name }
}
