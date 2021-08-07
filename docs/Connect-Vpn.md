---
external help file: vpn-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Connect-Vpn.md
schema: 2.0.0
---

# Connect-Vpn

## SYNOPSIS
This function connects VPN.

## SYNTAX

```
Connect-Vpn [-CfgFile] <String> [-KeyFile] <String> [-ConnectionName] <String> [<CommonParameters>]
```

## DESCRIPTION
This function in details:
* takes a dialup credentials list from configuration file,
* establishes VPN connection,
* supports encrypted secret data,
* uses rasdial tool to establish VPN connection.

## EXAMPLES

### Example 1
```
PS C:\> Connect-Vpn cfg.json encryption.key <vpn-connection-name>
```

Connects to named VPN. Pass your encryption.key file for secret data decryption.

### Example 2 Sample content of the `cfg.json`
```
{
    "vault"               : [
        {
            "type"        : "dialup",
            "secret"      : {
                "name"    : "<connection-name>",
                "domain"  : "<domainname>",
                "username": "<username>",
                "password": "<password>"
            }
            , "disabled": true
        }
    ]
}
```

> The values of the `secret` object properties **should be encrypted**.

## PARAMETERS

### -CfgFile
Configuration file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeyFile
Encryption key file.
If you don't have it, please see New-EncryptionKey.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConnectionName
VPN connection name to connect.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Connect-Vpn.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Connect-Vpn.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/vpn.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/vpn.psm1)

