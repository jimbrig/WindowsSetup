---
external help file: vault-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-WindowsCredentials.md
schema: 2.0.0
---

# Add-WindowsCredentials

## SYNOPSIS
This function adds domain Windows Credentials enumerated in configuration file.

## SYNTAX

```
Add-WindowsCredentials [-CfgFile] <String> [-KeyFile] <String> [<CommonParameters>]
```

## DESCRIPTION
This function in details:
* takes a domain credentials list from from configuration file,
* skips entries marked as disabled,
* stores all credentials left into Windows Vault,
* supports encrypted secret data.

## EXAMPLES

### Example 1
```
PS C:\> Add-WindowsCredentials cfg.json encryption.key
```

Adds user credentials into Windows Vault. Pass your encryption.key file for secret data decryption.

### Example 2 Sample content of the `cfg.json`
```
{
    "vault"               : [
        {
            "type"        : "domain",
            "secret":
            {
                "server"  :  "<hostname>",
                "username":  "<domainname>\\<username>",
                "password":  "<password>"
            },
            "disabled": true
        }
    ]
}
```

> Note that domainname and username is separated by the escaped back-slash.
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-WindowsCredentials.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-WindowsCredentials.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/vault.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/vault.psm1)

