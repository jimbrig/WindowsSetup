---
external help file: vscode-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudioCodeExtensions.md
schema: 2.0.0
---

# Install-VisualStudioCodeExtensions

## SYNOPSIS
This function installs Visual Studio Code Extensions enumerated in configuration file.

## SYNTAX

```
Install-VisualStudioCodeExtensions [-CfgFile] <String> [<CommonParameters>]
```

## DESCRIPTION
This function in details:
* takes a Visual Studio Code extensions list to install from configuration file,
* skips extensions marked as disabled,
* executes VS Code to install all extensions left.

## EXAMPLES

### Example 1
```
PS C:\> Install-VisualStudioCodeExtensions cfg.json
```

### Example 2: Sample content of the `cfg.json`
```
{
    "vscode"              : {
        "extensions"      : [
            { "name"      : "dbankier.vscode-instant-markdown" },
            {
                "name"    : "ms-mssql.mssql",
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

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudioCodeExtensions.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudioCodeExtensions.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/vscode.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/vscode.psm1)
