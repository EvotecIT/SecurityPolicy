---
external help file: SecurityPolicy-help.xml
Module Name: SecurityPolicy
online version:
schema: 2.0.0
---

# Get-SecurityPolicy

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### SystemAccess (Default)
```
Get-SecurityPolicy [-ConfigFile <String>] -SystemAccess <String> [<CommonParameters>]
```

### All
```
Get-SecurityPolicy [-ConfigFile <String>] [-All] [<CommonParameters>]
```

### EventAudit
```
Get-SecurityPolicy [-ConfigFile <String>] -EventAudit <String> [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ConfigFile
{{ Fill ConfigFile Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -All
{{ Fill All Description }}

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SystemAccess
{{ Fill SystemAccess Description }}

```yaml
Type: String
Parameter Sets: SystemAccess
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventAudit
Get specific setting from Event Audit section

```yaml
Type: String
Parameter Sets: EventAudit
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
