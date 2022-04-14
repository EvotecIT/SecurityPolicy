Import-Module .\SecurityPolicy.psd1 -Force

$Output = Get-UserRightsAssignement -UserRightsAssignment SeBackupPrivilege #-Computer AD1
$Output | Format-Table

Add-UserRightsAssignement -UserRightsAssignment SeBackupPrivilege -Identity "Evotec\Administrator"

$Output = Get-UserRightsAssignement -UserRightsAssignment SeBackupPrivilege #-Computer AD1
$Output | Format-Table

Remove-UserRightsAssignement -UserRightsAssignment SeBackupPrivilege -Identity "Evotec\Administrator"