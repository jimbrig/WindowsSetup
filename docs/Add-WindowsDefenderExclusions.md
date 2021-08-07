---
external help file: defender-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-WindowsDefenderExclusions.md
schema: 2.0.0
---

# Add-WindowsDefenderExclusions

## SYNOPSIS
This function add Windows defender exclusions.

## SYNTAX

```
Add-WindowsDefenderExclusions [[-ProcessesPaths] <String[]>] [[-ProcessesList] <String[]>]
 [[-FoldersPaths] <String[]>] [[-FoldersList] <String[]>] [[-FilesList] <String[]>]
 [[-ExtensionsList] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
This function in details adds exclusions for:
* specified processes,
* specified folders,
* specified files,
* specified extensions.

The primary aim is to improve developer machine performance.

## EXAMPLES

### Example 1
```
PS C:\> Add-WindowsDefenderExclusions
```

Adds default exclusions.
If you want to add custom exclusions you may consider using standard  `Add-MpPreference` cmdlet also.
Please, take a look at: `Get-Help Add-MpPreference` for more information.

## PARAMETERS

### -ProcessesPaths
Paths where specified processess should be search for.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: ( ${env:ProgramFiles(x86)}, $env:ProgramW6432 )
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProcessesList
Processess to exclude within Windows Defender.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: ( 'msbuild.exe', 'devenv.exe', 'sqlcmd.exe', 'sqllocaldb.exe', 'sqlservr.exe', 'sqlwriter.exe')
Accept pipeline input: False
Accept wildcard characters: False
```

### -FoldersPaths
Paths where specified folders should be search for.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: ( $env:USERPROFILE )
Accept pipeline input: False
Accept wildcard characters: False
```

### -FoldersList
Folders to exclude within Windows Defender.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: ( 'MyProjects', '.nuget', '.babun' )
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilesList
Files to exclude within Windows Defender.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: C:\pagefile.sys
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExtensionsList
File extensions to exclude within Windows Defender.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: ( 'config', 'cs' , 'ldf', 'lnk', 'mdf', 'ttf', 'txt', 'xml', 'log' )
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-WindowsDefenderExclusions.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-WindowsDefenderExclusions.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/defender.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/defender.psm1)
