---
external help file: config-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Merge-ConfigurationFiles.md
schema: 2.0.0
---

# Merge-ConfigurationFiles

## SYNOPSIS
This function combines configuration files.

## SYNTAX

```
Merge-ConfigurationFiles [-Files] <String[]> [[-ModulesPath] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function in details:
* loads Newtonsoft.Json library from specified location,
* parses all input files,
* merges them in the specified order,
* uses Newtonsoft.Json library with setting MergeArrayHandling.Union.

## EXAMPLES

### Example 1
```
PS C:\> Merge-ConfigurationFiles common.json, user.json
```

It merges two specified Json files using Merge(JObject, JsonMergeSettings) method of the JObject class
provided by the `Newtonsoft.Json library`. The output is merged Json formatted string.

### Example 2
```
PS C:\> Merge-ConfigurationFiles common.json, user.json | Out-File -Encoding utf8 merged.json
```

It merges two specified Json files and saves merged result into file `merged.json` with UTF-8 encoding.
Content of the `user.json` file supplements content of the `common.json` file.

## PARAMETERS

### -Files
An Array of the configuration files to combine.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModulesPath
Path where installed Newtonsoft.Json package can be found.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: C:\Program Files\WindowsPowerShell\Modules
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### String

## NOTES

## RELATED LINKS

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Merge-ConfigurationFiles.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Merge-ConfigurationFiles.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/config.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/config.psm1)

[http://www.newtonsoft.com/json/help/html/MergeJson.htm](http://www.newtonsoft.com/json/help/html/MergeJson.htm)

[http://www.newtonsoft.com/](http://www.newtonsoft.com/)
