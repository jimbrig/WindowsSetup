---
external help file: download-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Expand-DownloadedArchive.md
schema: 2.0.0
---

# Expand-DownloadedArchive

## SYNOPSIS
This function downloads zip files enumerated in configuration file.

## SYNTAX

```
Expand-DownloadedArchive [-CfgFile] <String> [<CommonParameters>]
```

## DESCRIPTION
This function in details:
* takes a zip file list to download from configuration file,
* downloads each zip file,
* extracts each file to location specified in configuration file.

## EXAMPLES

### Example 1
```
PS C:\> Expand-DownloadedArchive cfg.json
```

### Example 3 Sample content of the `cfg.json`
```
{
    "download": {
        "zip" : [
            {
                "url": "<url-to-zip-archive>",
                "destination": "<drive:\\destination\\path>"
            }
        ]
    }
}
```

> Note, that back-slash should be escaped with another back-slash char.

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

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Expand-DownloadedArchive.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Expand-DownloadedArchive.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/download.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/download.psm1)
