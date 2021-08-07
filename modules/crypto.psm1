Function Global:Encrypt {
  <#
    .SYNOPSIS
    Encrypts Value property of the piece of JSON.
    .PARAMETER Json
    A piece of the JSON file.
    .PARAMETER KeyFile
    Encryption key file. If you don't have it, please see New-EncryptionKey.
    .INPUTS
    PSCustomObject (Json object)
#>
  Param ( [Parameter(Mandatory = $true)][String] $KeyFile
    , [Parameter(Mandatory = $true, ValueFromPipeline = $true)] $Json )

  Process {
    $Json.psobject.Properties |
    ForEach-Object {
      $_.Value = ( $_.Value |
        ConvertTo-SecureString   -AsPlainText -Force |
        ConvertFrom-SecureString -Key (Get-Content $KeyFile ) )
    }
  }
}

Function Global:Decrypt {
  <#
    .SYNOPSIS
    Decrypts Value property of the piece of JSON.
    .PARAMETER Json
    A piece of the JSON file.
    .PARAMETER KeyFile
    Encryption key file. If you don't have it, please see New-EncryptionKey.
    .INPUTS
    PSCustomObject (Json object)
#>
  Param ( [Parameter(Mandatory = $true)][String] $KeyFile
    , [Parameter(Mandatory = $true, ValueFromPipeline = $true)] $Json )

  Process {
    $Json.psobject.Properties |
    ForEach-Object {
      $secureString = $_.Value |
      ConvertTo-SecureString -Key (Get-Content $KeyFile)

      $_.Value = ( New-Object System.Net.NetworkCredential ("n/a", $secureString) |
        Select-Object -ExpandProperty Password )
    }
  }
}

Function New-EncryptionKey {
  <#
    .SYNOPSIS
    Creates new encryption key based on the input file.
    .DESCRIPTION
    This function in details:
    * gets MD5 hash of the input file
    * converts MD5 hash into a byte array that may be used with SecureString as encryption key.
    .PARAMETER InputFile
    Any file to compute encryption key from using its MD5 hash.
    .OUTPUTS
    Byte[] - Encryption key to use with SecureString.
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md
    .LINK
    https://github.com/a4099181/vagrant-provvin/blob/master/modules/crypto.psm1
#>

  Param ( [Parameter(Mandatory = $true)][String] $InputFile )

  return Get-FileHash $InputFile -Algorithm MD5 |
  Select-Object -ExpandProperty Hash |
  Select-Object  @{
    Name       = "ByteArray";
    Expression = { [System.Text.Encoding]::ASCII.GetBytes( $_ ) } 
  } |
  Select-Object -ExpandProperty ByteArray
}
