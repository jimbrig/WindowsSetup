---
external help file: git-clone-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Copy-GitRepositories.md
schema: 2.0.0
---

# Copy-GitRepositories

## SYNOPSIS
This function clones git respositories enumerated in configuration file.

## SYNTAX

```
Copy-GitRepositories [-CfgFile] <String> [[-DestinationFolder] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function in details:
* creates destination folder if it not exists,
* takes a repositores list to clone from configuration file,
* skips repositories marked as disabled,
* clones each repository left,
* uses a git that should be already provisioned and accessible,
* clones the repositories into specified destination folder,
* initializes submodules within repositories.

## EXAMPLES

### Example 1
```
PS C:\> Copy-GitRepositories cfg.json
```

Clones git repositories into default destination folder.

### Example 2
```
PS C:\> Copy-GitRepositories cfg.json -DestinationFolder your/custom/destination/folder
```

Clones git repositories into custom destination folder.

### Example 3 Sample content of the `cfg.json`
```
{
    "repos"           :  [
        { "url"       :  "http://tfs2.soneta.int:8080/tfs/enova/enova-git/_git/enova.git" },
        {
            "url"     :  "http://tfs2.soneta.int:8080/tfs/enova/enova-git/_git/generator.git",
            "disabled": true
        }
    ]
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

### -DestinationFolder
Destination folder for cloned repositories.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: ( Join-Path $env:UserProfile 'MyProjects' )
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Copy-GitRepositories.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Copy-GitRepositories.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/git-clone.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/git-clone.psm1)
