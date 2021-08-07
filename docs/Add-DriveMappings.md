---
external help file: map-drives-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-DriveMappings.md
schema: 2.0.0
---

# Add-DriveMappings

## SYNOPSIS
This function adds network drive mappings.

## SYNTAX

```
Add-DriveMappings [-CfgFile] <String> [-KeyFile] <String> [<CommonParameters>]
```

## DESCRIPTION
This function in details:
* takes a drives mappings list from a configuration file,
* skips entries marked as disabled,
* maps drive persistently for each entry left,
* supports encrypted secret data.

## EXAMPLES

### Example 1
```
PS C:\> Add-DriveMappings cfg.json encryption.key
```

Maps network shares to drive letters. Pass your encryption.key file for secret data decryption.

### Example 2 Sample content of the `cfg.json`
```
{
    "drives": [
        {
            "local":  "<drive-letter>",
            "secret":
                { "remote":  "\\\\<share-host>\\<share-name>" },
                "disabled": true
        }
    ]
}
```

> Note that back-slashes in UNC paths should be escaped.
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

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-DriveMappings.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-DriveMappings.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/map-drives.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/map-drives.psm1)

