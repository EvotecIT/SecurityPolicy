function Add-UserRightsAssignment {
    <#
    .SYNOPSIS
    Add identity object to the specified user rights Assignment role.

    .DESCRIPTION
    Add identity object to the specified user rights Assignment role.

    .PARAMETER UserRightsAssignment
    Choose user rights assignment

    .PARAMETER Computer
    Choose computer name. If not specified, the current computer will be used.

    .PARAMETER Identity
    Choose identity object by providing it's full name

    .PARAMETER Suppress
    Suppress the output. By default returns the identity what happend as an object.

    .EXAMPLE
    Add-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege -Identity "Evotec\Administrator"

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

    if ($PSCmdlet.ShouldProcess("Adding $($ConvertedIdentity.Name)/$($ConvertedIdentity.Sid) to $UserRightsAssignment", 'Add-UserRightsAssignment')) {
        try {
            if ($Computer) {
                $LsaWrapper = [LocalSecurityEditor.LsaWrapper]::new($Computer)
            } else {
                $LsaWrapper = [LocalSecurityEditor.LsaWrapper]::new()
            }
        } catch {
            if (-not $Suppress) {
                [PSCustomObject] @{
                    "Action"               = 'Add'
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
                Write-Warning -Message "Add-UserRightsAssignment - Could not create LsaWrapper. Error: $($_.Exception.Message)"
                return
            }
        }
        try {
            $null = $LsaWrapper.AddPrivileges($ConvertedIdentity.Name, $UserRightsAssignment)
            if (-not $Suppress) {
                [PSCustomObject] @{
                    "Action"               = 'Add'
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
                    "Action"               = 'Add'
                    "Identity"             = $ConvertedIdentity.Name
                    'SID'                  = $ConvertedIdentity.Sid
                    "UserRightsAssignment" = $UserRightsAssignment
                    "Status"               = 'Failure'
                    "Error"                = $($_.Exception.Message)
                }
            }
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                Write-Error "Could not add privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
                return
            } else {
                Write-Warning -Message "Add-UserRightsAssignment - Could not add privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
            }
        }
        try {
            $LsaWrapper.Dispose()
        } catch {
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                Write-Error "Could not dispose LsaWrapper. Error: $($_.Exception.Message)"
            } else {
                Write-Warning -Message "Add-UserRightsAssignment - Could not dispose LsaWrapper. Error: $($_.Exception.Message)"
            }
        }
    } else {
        if (-not $Suppress) {
            [PSCustomObject] @{
                "Action"               = 'Add'
                "Identity"             = $ConvertedIdentity.Name
                'SID'                  = $ConvertedIdentity.Sid
                "UserRightsAssignment" = $UserRightsAssignment
                "Status"               = 'WhatIf'
                "Error"                = 'WhatIf in use.'
            }
        }
    }
}