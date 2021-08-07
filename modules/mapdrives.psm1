Function Add-DriveMappings {
  <#
    .SYNOPSIS
    This function adds network drive mappings.
    .DESCRIPTION
    This function in details:
    * takes a drives mappings list from a configuration file,
    * skips entries marked as disabled,
    * maps drive persistently for each entry left,
    * supports encrypted secret data.
    .PARAMETER CfgFile
    Configuration file.
    .PARAMETER KeyFile
    Encryption key file. If you don't have it, please see New-EncryptionKey.
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-DriveMappings.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/map-drives.psm1
    #>

  Param(
    [Parameter(Mandatory = $true)] [String] $CfgFile,
    [Parameter(Mandatory = $true)] [String] $KeyFile )

  $pass = ConvertTo-SecureString -AsPlainText -Force "vagrant"
  $cred = New-Object pscredential("vagrant", $pass)

  $cfg = Get-Content $CfgFile | ConvertFrom-Json

  $cfg.drives |
  Select-Object -expand secret |
  Decrypt $KeyFile

  $cfg.drives |
  Where-Object { -Not $_.disabled } |
  ForEach-Object {
    Start-Process powershell -Credential $cred -LoadUserProfile -NoNewWindow -Wait `
      -ArgumentList "-NoProfile", `
      @"
            New-SmbMapping -LocalPath $($_.local) -RemotePath $($_.secret.remote) ``
                -Persistent `$True -SaveCredentials
"@
  }
}
