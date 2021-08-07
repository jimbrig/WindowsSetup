---
external help file: vs2017-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudio2017.md
schema: 2.0.0
---

# Install-VisualStudio2017

## SYNOPSIS
This function installs Visual Studio 2017 Enterprise with custom workloads and components.

## SYNTAX

```
Install-VisualStudio2017 [-CfgFile] <String> [[-InstallerUri] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function in details:
* downloads Visual Studio from specified installer URI,
* takes a Visual Studio components list to install from configuration file,
* skips components marked as disabled,
* runs the installer silently with all components left.

The list of the Visual Studio workloads and components is available at
https://www.visualstudio.com/en-us/productinfo/vs2017-install-product--list

## EXAMPLES

### Example 1
```
PS C:\> Install-VisualStudio2017 cfg.json
```

### Example 2 Sample content of the `cfg.json`
```
{
    "vs2017"              : {
        "components"      : [
            { "id"        : "Microsoft.VisualStudio.Workload.ManagedDesktop" },
            {
                "id"      : "Microsoft.Net.ComponentGroup.TargetingPacks.Common",
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

### -InstallerUri
Installer URI to download it from.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Https://aka.ms/vs/15/release/vs_Enterprise.exe
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudio2017.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Install-VisualStudio2017.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/vs2017.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/vs2017.psm1)

[https://www.visualstudio.com/en-us/productinfo/vs2017-install-product--list](https://www.visualstudio.com/en-us/productinfo/vs2017-install-product--list)
