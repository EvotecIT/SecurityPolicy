Clear-Host
Import-Module .\SecurityPolicy.psd1 -Force

$SecurityPolicies = Get-SecurityPolicy -Verbose -All
$SecurityPolicies | Format-Table