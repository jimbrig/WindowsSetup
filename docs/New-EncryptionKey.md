---
external help file: crypto-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md
schema: 2.0.0
---

# New-EncryptionKey

## SYNOPSIS
Creates new encryption key based on the input file.

## SYNTAX

```
New-EncryptionKey [-InputFile] <String> [<CommonParameters>]
```

## DESCRIPTION
This function in details:
* gets MD5 hash of the input file
* converts MD5 hash into a byte array that may be used with SecureString as encryption key.

## EXAMPLES

### Example 1
```
PS C:\> New-EncryptionKey <any-file-you-want>
```

Creates new encryption key based on any file you choose. Only you know that file.

### Example 2
```
PS C:\> New-EncryptionKey <any-file-you-want> | Out-File .vagrant\my-private.key
```

Creates new encryption key and stores it in `.vagrant\my-private.key` for future use.

> Note, that `.vagrant\my-private.key` is the same location as defined in [Vagrantfile](../Vagrantfile).
> If you store encryption key in any other location, then you need update [Vagrantfile](../Vagrantfile) also.

## PARAMETERS

### -InputFile
Any file to compute encryption key from using its MD5 hash.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Byte[] - Encryption key to use with SecureString.

## NOTES

## RELATED LINKS

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/New-EncryptionKey.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/crypto.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/crypto.psm1)
