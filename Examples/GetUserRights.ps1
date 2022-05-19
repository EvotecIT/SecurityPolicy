Import-Module .\SecurityPolicy.psd1 -Force

$Output = Get-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege #-Computer AD1
$Output | Format-Table

Add-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege -Identity "Evotec\Administrator"

$Output = Get-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege #-Computer AD1
$Output | Format-Table

Remove-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege -Identity "Evotec\Administrator"