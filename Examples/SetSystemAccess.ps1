Clear-Host
Import-Module .\SecurityPolicy.psd1 -Force

$SecurityPolicies = Get-SecurityPolicy -Verbose -SystemAccess MinimumPasswordAge
$SecurityPolicies | Format-Table

Set-SecurityPolicy -SystemAccess MinimumPasswordAge -Value 1 -whatif