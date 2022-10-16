Import-Module .\SecurityPolicy.psd1 -Force

$Output = Get-UserRightsAssignment -UserRightsAssignment SeTrustedCredManAccessPrivilege #-Computer AD1
$Output | Format-Table

Remove-UserRightsAssignment -UserRightsAssignment SeTrustedCredManAccessPrivilege -Identity "S-1-5-21-853615985-2870445339-3163598659-4098"

$Output = Get-UserRightsAssignment -UserRightsAssignment SeTrustedCredManAccessPrivilege #-Computer AD1
$Output | Format-Table

$Output = Get-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege #-Computer AD1
$Output | Format-Table

Add-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege -Identity "Evotec\Administrator"

$Output = Get-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege #-Computer AD1
$Output | Format-Table

Remove-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege -Identity "Evotec\Administrator"

$Output = Get-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege #-Computer AD1
$Output | Format-Table