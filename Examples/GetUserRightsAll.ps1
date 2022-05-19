Import-Module .\SecurityPolicy.psd1 -Force

$Output = Get-UserRightsAssignment -All
$Output | Format-Table

# requires PSWriteHTML
New-HTML {
    foreach ($Category in $Output.Keys) {
        New-HTMLSection -HeaderText $Category {
            New-HTMLTable -DataTable $Output[$Category] -Filtering
        }
    }
} -ShowHTML -Online