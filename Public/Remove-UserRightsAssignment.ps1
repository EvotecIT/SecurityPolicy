function Remove-UserRightsAssignment {
    <#
    .SYNOPSIS
    Remove identity object from User Rights Assignment role

    .DESCRIPTION
    Remove identity object from User Rights Assignment role

    .PARAMETER UserRightsAssignment
    Choose user rights assignment

    .PARAMETER Computer
    Choose computer name. If not specified, the current computer will be used.

    .PARAMETER Identity
    Provide the user name to remove the user rights assignment for

    .PARAMETER Suppress
    Suppress the output. By default returns the identity what happend as an object.

    .EXAMPLE
    Remove-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege -Identity "Evotec\Administrator"

    .NOTES
    General notes
    #>
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory)][LocalSecurityEditor.UserRightsAssignment] $UserRightsAssignment,
        [alias('ComputerName')][string] $Computer,
        [parameter(Mandatory)][alias('UserName')][string] $Identity,
        [switch] $Suppress
    )

    $ConvertedIdentity = Convert-Identity -Identity $Identity

    try {
        if ($Computer) {
            $LsaWrapper = [LocalSecurityEditor.LsaWrapper]::new($Computer)
        } else {
            $LsaWrapper = [LocalSecurityEditor.LsaWrapper]::new()
        }
    } catch {
        if (-not $Suppress) {
            [PSCustomObject] @{
                "Action"               = 'Remove'
                "Identity"             = $ConvertedIdentity.Name
                'SID'                  = $ConvertedIdentity.Sid
                "UserRightsAssignment" = $UserRightsAssignment
                "Status"               = 'Failed'
                "Error"                = $($_.Exception.Message)
            }
        }
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            Write-Error "Could not create LsaWrapper. Error: $($_.Exception.Message)"
            return
        } else {
            Write-Warning -Message "Remove-UserRightsAssignment - Could not create LsaWrapper. Error: $($_.Exception.Message)"
            return
        }
    }
    if ($PSCmdlet.ShouldProcess("Removing $($ConvertedIdentity.Name)/$($ConvertedIdentity.Sid) from $UserRightsAssignment", 'Add-UserRightsAssignment')) {
        try {
            $LsaWrapper.RemovePrivileges($ConvertedIdentity.Name, $UserRightsAssignment)
            if (-not $Suppress) {
                [PSCustomObject] @{
                    "Action"               = 'Remove'
                    "Identity"             = $ConvertedIdentity.Name
                    'SID'                  = $ConvertedIdentity.Sid
                    "UserRightsAssignment" = $UserRightsAssignment
                    "Status"               = 'Success'
                    "Error"                = ''
                }
            }
        } catch {
            if (-not $Suppress) {
                [PSCustomObject] @{
                    "Action"               = 'Remove'
                    "Identity"             = $ConvertedIdentity.Name
                    'SID'                  = $ConvertedIdentity.Sid
                    "UserRightsAssignment" = $UserRightsAssignment
                    "Status"               = 'Failed'
                    "Error"                = $($_.Exception.Message)
                }
            }
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                Write-Error "Could not remove privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
                return
            } else {
                Write-Warning -Message "Remove-UserRightsAssignment - Could not remove privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
                return
            }
        }
        try {
            $LsaWrapper.Dispose()
        } catch {
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                Write-Error "Could not dispose LsaWrapper. Error: $($_.Exception.Message)"
                return
            } else {
                Write-Warning -Message "Remove-UserRightsAssignment - Could not dispose LsaWrapper. Error: $($_.Exception.Message)"
                return
            }
        }
    } else {
        if (-not $Suppress) {
            [PSCustomObject] @{
                "Action"               = 'Remove'
                "Identity"             = $ConvertedIdentity.Name
                'SID'                  = $ConvertedIdentity.Sid
                "UserRightsAssignment" = $UserRightsAssignment
                "Status"               = 'WhatIf'
                "Error"                = 'WhatIf in use.'
            }
        }
    }
}