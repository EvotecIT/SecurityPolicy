Clear-Host
Import-Module .\SecurityPolicy.psd1 -Force

$SecurityPolicies = Get-SecurityPolicy -Verbose -All
# $SecurityPolicies | Format-Table

# $SecurityPolicies.'Unicode' | Format-Table
$SecurityPolicies.'System Access' | Format-Table
# $SecurityPolicies.'Event Audit' | Format-Table
# $SecurityPolicies.'Registry Values' | Format-Table
# $SecurityPolicies.'Privilege Rights' | Format-Table
# $SecurityPolicies.'Version' | Format-Table


Set-SecurityPolicy -SystemAccess MinimumPasswordAge -Value 1