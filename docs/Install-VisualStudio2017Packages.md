---
external help file: vs2017-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudio2017Packages.md
schema: 2.0.0
---

# Install-VisualStudio2017Packages

## SYNOPSIS
This function installs Visual Studio related software enumerated in configuration file.

## SYNTAX

```
Install-VisualStudio2017Packages [-CfgFile] <String> [<CommonParameters>]
```

## DESCRIPTION
This function in details:
* takes a Visual Studio related software list to install from a configruation file,
* skips software marked as disabled,
* installs all software left,
* uses chocolatey package manager.

## EXAMPLES

### Example 1
```
PS C:\> Install-VisualStudio2017Packages cfg.json
```

### Example 2 Sample content of the `cfg.json`
```
{
    "vs2017"                  : {
        "chocolatey"          : {
            "packages"        : [
                { "id"        : "microsoft-build-tools" },
                {
                    "id"      : "resharper",
                    "disabled": true
                }
            ]
        }
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

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudio2017Packages.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudio2017Packages.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/vs2017.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/vs2017.psm1)

[https://chocolatey.org/packages](https://chocolatey.org/packages)
