Function Merge-ConfigurationFiles {
  <#
    .SYNOPSIS
    This function combines configuration files.
    .DESCRIPTION
    This function in details:
    * loads Newtonsoft.Json library from specified location,
    * parses all input files,
    * merges them in the specified order,
    * uses Newtonsoft.Json library with setting MergeArrayHandling.Union.
    .PARAMETER Files
    An Array of the configuration files to combine.
    .PARAMETER ModulesPath
    Path where installed Newtonsoft.Json package can be found.
    .OUTPUTS
    String
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Merge-ConfigurationFiles.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/config.psm1
    .LINK
    http://www.newtonsoft.com/json/help/html/MergeJson.htm
    .LINK
    http://www.newtonsoft.com/
#>
  Param ( [Parameter(Mandatory = $true)][String[]] $Files
    , [String] $ModulesPath = "C:\Program Files\WindowsPowerShell\Modules" )

  Get-Package newtonsoft.json |
  ForEach-Object { Add-Type -Path "$($ModulesPath)\$($_.Name)\$($_.Version)\libs\$($_.Name).dll" }

  $cmmn = [Newtonsoft.Json.Linq.JObject]::Parse(
    ( Get-Content -Raw ( $Files | Select-Object -First 1 ) ) )

  $Files |
  Select-Object -Skip 1 |
  ForEach-Object {
    $other = [Newtonsoft.Json.Linq.JObject]::Parse( ( Get-Content -Raw -Path $_ ) )

    $sets = New-Object -TypeName Newtonsoft.Json.Linq.JsonMergeSettings
    $sets.MergeArrayHandling = [Newtonsoft.Json.Linq.MergeArrayHandling]::Union

    $cmmn.Merge( $other, $sets )
  }

  $merged = $cmmn.ToString() | ConvertFrom-Json

  $merged.chocolatey.packages = Remove-Disabled $merged.chocolatey.packages        id
  $merged.vscode.extensions = Remove-Disabled $merged.vscode.extensions          name
  $merged.vs2017.components = Remove-Disabled $merged.vs2017.components          id
  $merged.vs2017.extensions = Remove-Disabled $merged.vs2017.extensions          name
  $merged.vs2017.chocolatey.packages = Remove-Disabled $merged.vs2017.chocolatey.packages id
  $merged.repos = Remove-Disabled $merged.repos                      url

  $merged | ConvertTo-Json -Depth 4
}

Function Protect-Config {
  <#
    .SYNOPSIS
    This function encrypts specified configuration file.
    .DESCRIPTION
    This function in details:
    * searches for encryptable objects: drives, vault, repos,
    * encrypts secret objects inside objects found,
    * it overwrites plain config file with the encrypted one.
    .PARAMETER CfgFile
    Configuration file.
    .PARAMETER KeyFile
    Encryption key file. If you don't have it, please see New-EncryptionKey.
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Unprotect-Config.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/config.psm1
#>

  Param ( [Parameter(Mandatory = $true)][String] $CfgFile
    , [Parameter(Mandatory = $true)][String] $KeyFile )

  Try {
    $jsn = Get-Content $CfgFile | ConvertFrom-Json

    @( $jsn.drives, $jsn.vault, $jsn.repos ) |
    ForEach-Object { $_.secret | ? { $_ -ne $null } | Encrypt $KeyFile }
    ConvertTo-Json $jsn -Depth 4 | Out-File -Encoding utf8 $CfgFile
  }
  Catch {
    Throw
  }
}

Function Unprotect-Config {
  <#
    .SYNOPSIS
    This function decrypts specified configuration file.
    .DESCRIPTION
    This function in details:
    * searches for decryptable objects: drives, vault, repos,
    * decrypts secret objects inside objects found,
    * it overwrites encrypted config file with the plain one.
    .PARAMETER CfgFile
    Configuration file.
    .PARAMETER KeyFile
    Encryption key file. If you don't have it, please see New-EncryptionKey.
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Unprotect-Config.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/config.psm1
#>

  Param ( [Parameter(Mandatory = $true)][String] $CfgFile
    , [Parameter(Mandatory = $true)][String] $KeyFile )

  Try {
    $jsn = Get-Content $CfgFile | ConvertFrom-Json

    @( $jsn.drives, $jsn.vault, $jsn.repos ) |
    ForEach-Object { $_.secret | ? { $_ -ne $null } | Decrypt $KeyFile }

    ConvertTo-Json $jsn -Depth 4 | Out-File -Encoding utf8 $CfgFile
  }
  Catch {
    Throw
  }
}

Function Remove-Disabled {
  Param ( [Parameter(Mandatory = $true)] [PsCustomObject] $merged,
    [Parameter(Mandatory = $true)]                  $id )

  $disabled = $merged | group disabled

  $disabled[ $false ] |
  Select-Object -expand Group |
  ? $id -NotIn ( $disabled[ $true ] | Select-Object -expand Group | Select-Object -expand $id )
}
