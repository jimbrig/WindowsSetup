---
external help file: chocolatey-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-CommonPackages.md
schema: 2.0.0
---

# Install-CommonPackages

## SYNOPSIS
This function installs packages enumerated in configuration files.

## SYNTAX

```
Install-CommonPackages [-CfgFile] <String> [<CommonParameters>]
```

## DESCRIPTION
This function in details:
* takes a list of packages from configuration file,
* skips packages marked as disabled,
* installs each package left,
* uses chocolatey package manager.

## EXAMPLES

### Example 1
```
PS C:\> Install-CommonPackages cfg.json
```

### Example 2 Sample content of the `cfg.json`
```
{
    "chocolatey"          : {
        "packages"        : [
            { "id"        : "git-credential-manager-for-windows" },
            {
                "id"      : "inconsolata",
                "disabled": true
            }
        ]
    }
}
```

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-CommonPackages.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-CommonPackages.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/chocolatey.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/chocolatey.psm1)

[https://chocolatey.org/packages](https://chocolatey.org/packages)
