---
external help file: vpn-help.xml
online version: https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-VpnConnectionTriggers.md
schema: 2.0.0
---

# Add-VpnConnectionTriggers

## SYNOPSIS
This function adds VPN connection triggers.

## SYNTAX

```
Add-VpnConnectionTriggers [-ConnectionName] <String> [[-ExecutablePaths] <String[]>]
 [[-Executables] <String[]>] [[-UniversalApps] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
This function in details registers VPN application triggers for specified
* executables,
* universal apps.

The primary aim is more ergonomics.

## EXAMPLES

### Example 1
```
PS C:\> Add-VpnConnectionTriggers
```

Adds default VPN connection triggers.
If you want to add custom VPN connection trigger you may consider using standard  `Add-VpnConnectionTriggerApplication` cmdlet also.
Please, take a look at: `Get-Help Add-VpnConnectionTriggerApplication` for more information.

## PARAMETERS

### -ConnectionName
VPN connection name.

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

### -ExecutablePaths
Paths where specified executable should be search for.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: ( ${env:ProgramFiles(x86)}, $env:ProgramW6432 , $env:USERPROFILE, "$env:windir\System32" )
Accept pipeline input: False
Accept wildcard characters: False
```

### -Executables
Executable to register as VPN connection triggers.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: ( 'devenv.exe', 'eTask.exe', 'mintty.exe', 'mstsc.exe' )
Accept pipeline input: False
Accept wildcard characters: False
```

### -UniversalApps
Universal Apps to register as VPN connection triggers.

Please note, that universal app are searched using .EndsWith(\<param-value\>) function.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: .MicrosoftEdge
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-VpnConnectionTriggers.md](https://github.com/a4099181/vagrant-provvin/blob/master/docs/Add-VpnConnectionTriggers.md)

[https://github.com/a4099181/vagrant-provvin/blob/master/modules/vpn.psm1](https://github.com/a4099181/vagrant-provvin/blob/master/modules/vpn.psm1)
