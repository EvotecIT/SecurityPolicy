Clear-Host
Import-Module .\SecurityPolicy.psd1 -Force

$Output = Get-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege #-Computer AD1
$Output | Format-Table

$Identity = @(
    'BUILTIN\Backup Operators'
    'BUILTIN\Administrators'
    'Guest'
    #'BUILTIN\Users'
    #'przemyslaw.klys'
)

Set-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege -Identity $Identity -WhatIf #-Computer AD1

$Output = Get-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege #-Computer AD1
$Output | Format-Table