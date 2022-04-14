---
external help file: SecurityPolicy-help.xml
Module Name: SecurityPolicy
online version:
schema: 2.0.0
---

# Get-UserRightsAssignement

## SYNOPSIS
Provides a list of users assigned to a specific role.

## SYNTAX

### UserRights (Default)
```
Get-UserRightsAssignement -UserRightsAssignment <UserRightsAssignment> [-Computer <String>]
 [<CommonParameters>]
```

### All
```
Get-UserRightsAssignement [-Computer <String>] [-All] [<CommonParameters>]
```

## DESCRIPTION
Provides a list of users assigned to a specific role.

## EXAMPLES

### EXAMPLE 1
```
Get-UserRightsAssignement -All
```

### EXAMPLE 2
```
Get-UserRightsAssignement -UserRightsAssignment SeBackupPrivilege
```

## PARAMETERS

### -UserRightsAssignment
Choose the role to list the users assigned to.

```yaml
Type: UserRightsAssignment
Parameter Sets: UserRights
Aliases:
Accepted values: SeTrustedCredManAccessPrivilege, SeNetworkLogonRight, SeTcbPrivilege, SeMachineAccountPrivilege, SeIncreaseQuotaPrivilege, SeInteractiveLogonRight, SeRemoteInteractiveLogonRight, SeBackupPrivilege, SeChangeNotifyPrivilege, SeSystemtimePrivilege, SeTimeZonePrivilege, SeCreatePagefilePrivilege, SeCreateTokenPrivilege, SeCreateGlobalPrivilege, SeCreatePermanentPrivilege, SeCreateSymbolicLinkPrivilege, SeDebugPrivilege, SeDenyNetworkLogonRight, SeDenyBatchLogonRight, SeDenyServiceLogonRight, SeDenyInteractiveLogonRight, SeDenyRemoteInteractiveLogonRight, SeEnableDelegationPrivilege, SeRemoteShutdownPrivilege, SeAuditPrivilege, SeImpersonatePrivilege, SeIncreaseWorkingSetPrivilege, SeIncreaseBasePriorityPrivilege, SeLoadDriverPrivilege, SeLockMemoryPrivilege, SeBatchLogonRight, SeServiceLogonRight, SeSecurityPrivilege, SeRelabelPrivilege, SeSystemEnvironmentPrivilege, SeDelegateSessionUserImpersonatePrivilege, SeManageVolumePrivilege, SeProfileSingleProcessPrivilege, SeSystemProfilePrivilege, SeUndockPrivilege, SeAssignPrimaryTokenPrivilege, SeRestorePrivilege, SeShutdownPrivilege, SeSyncAgentPrivilege, SeTakeOwnershipPrivilege

Required: True
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -All
Get all users for all user rights assignment for the specified computer.

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: False
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
