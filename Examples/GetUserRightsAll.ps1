Import-Module .\SecurityPolicy.psd1 -Force

$Output = Get-UserRightsAssignement -All
$Output | Format-Table