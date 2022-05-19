---
external help file: SecurityPolicy-help.xml
Module Name: SecurityPolicy
online version:
schema: 2.0.0
---

# Remove-UserRightsAssignment

## SYNOPSIS
Remove identity object from User Rights Assignment role

## SYNTAX

```
Remove-UserRightsAssignment [-UserRightsAssignment] <UserRightsAssignment> [[-Computer] <String>]
 [-Identity] <String> [-Suppress] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove identity object from User Rights Assignment role

## EXAMPLES

### EXAMPLE 1
```
Remove-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege -Identity "Evotec\Administrator"
```

## PARAMETERS

### -UserRightsAssignment
Choose user rights assignment

```yaml
Type: UserRightsAssignment
Parameter Sets: (All)
Aliases:
Accepted values: SeTrustedCredManAccessPrivilege, SeNetworkLogonRight, SeTcbPrivilege, SeMachineAccountPrivilege, SeIncreaseQuotaPrivilege, SeInteractiveLogonRight, SeRemoteInteractiveLogonRight, SeBackupPrivilege, SeChangeNotifyPrivilege, SeSystemtimePrivilege, SeTimeZonePrivilege, SeCreatePagefilePrivilege, SeCreateTokenPrivilege, SeCreateGlobalPrivilege, SeCreatePermanentPrivilege, SeCreateSymbolicLinkPrivilege, SeDebugPrivilege, SeDenyNetworkLogonRight, SeDenyBatchLogonRight, SeDenyServiceLogonRight, SeDenyInteractiveLogonRight, SeDenyRemoteInteractiveLogonRight, SeEnableDelegationPrivilege, SeRemoteShutdownPrivilege, SeAuditPrivilege, SeImpersonatePrivilege, SeIncreaseWorkingSetPrivilege, SeIncreaseBasePriorityPrivilege, SeLoadDriverPrivilege, SeLockMemoryPrivilege, SeBatchLogonRight, SeServiceLogonRight, SeSecurityPrivilege, SeRelabelPrivilege, SeSystemEnvironmentPrivilege, SeManageVolumePrivilege, SeProfileSingleProcessPrivilege, SeSystemProfilePrivilege, SeUndockPrivilege, SeAssignPrimaryTokenPrivilege, SeRestorePrivilege, SeShutdownPrivilege, SeSyncAgentPrivilege, SeTakeOwnershipPrivilege, SeDelegateSessionUserImpersonatePrivilege

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Computer
Choose computer name.
If not specified, the current computer will be used.

```yaml
Type: String
Parameter Sets: (All)
Aliases: ComputerName

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Identity
Provide the user name to remove the user rights assignment for

```yaml
Type: String
Parameter Sets: (All)
Aliases: UserName

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Suppress
Suppress the output.
By default returns the identity what happend as an object.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS
