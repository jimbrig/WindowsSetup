---
external help file: config-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md
schema: 2.0.0
---

# Protect-Config

## SYNOPSIS
This function encrypts specified configuration file.

## SYNTAX

```
Protect-Config [-CfgFile] <String> [-KeyFile] <String> [<CommonParameters>]
```

## DESCRIPTION
This function in details:
* searches for encryptable objects: drives, vault,
* encrypts secret objects inside objects found,
* it overwrites plain config file with the encrypted one.

## EXAMPLES

### Example 1
```
PS C:\> Unprotect-Config cfg.json encryption.key
```

It expects plain cfg.json file. Takes the config file, encrypts it and stores its encrypted version in the same place.

> Note, that after this operation sensitive data are secured. If you want to update your passwords or other secret data,
> then you mast unprotect that file back. See [Unprotect-Config](Unprotect-Config.md).

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

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Protect-Config.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Unprotect-Config.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Unprotect-Config.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/config.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/config.psm1)
