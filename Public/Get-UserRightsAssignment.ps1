function Get-UserRightsAssignement {
    <#
    .SYNOPSIS
    Provides a list of users assigned to a specific role.

    .DESCRIPTION
    Provides a list of users assigned to a specific role.

    .PARAMETER UserRightsAssignment
    Get all users for specific user rights assignment for specified computer.

    .PARAMETER Computer
    Parameter description

    .PARAMETER All
    Get all users for all user rights assignment for the specified computer.

    .EXAMPLE
    Get-UserRightsAssignement -All

    .EXAMPLE
    Get-UserRightsAssignement -UserRightsAssignment SeBackupPrivilege

    .NOTES
    General notes
    #>
    [cmdletBinding(DefaultParameterSetName = 'UserRights')]
    param(
        [parameter(Mandatory, ParameterSetName = 'UserRights')][SecurityEditor.UserRightsAssignment] $UserRightsAssignment,
        [alias('ComputerName')][string] $Computer,
        [parameter(ParameterSetName = 'All')][switch] $All
    )

    try {
        if ($Computer) {
            $LsaWrapper = [SecurityEditor.LsaWrapper]::new($Computer)
        } else {
            $LsaWrapper = [SecurityEditor.LsaWrapper]::new()
        }
    } catch {
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            Write-Error "Could not create LsaWrapper. Error: $($_.Exception.Message)"
            return
        } else {
            Write-Warning -Message "Get-UserRightsAssignement - Could not create LsaWrapper. Error: $($_.Exception.Message)"
            return
        }
    }
    if ($All) {
        $Output = [ordered] @{}
        $EnumValues = [Enum]::GetNames([SecurityEditor.UserRightsAssignment])
        foreach ($Value in $EnumValues | Sort-Object) {
            $Output[$Value] = try {
                $LsaWrapper.GetPrivileges($Value)
            } catch {
                if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                    Write-Error "Could not get privileges for $Value. Error: $($_.Exception.Message)"
                    return
                } else {
                    Write-Warning -Message "Get-UserRightsAssignement - Could not get privileges for $Value. Error: $($_.Exception.Message)"
                }
            }
        }
        $Output
    } else {
        try {
            $LsaWrapper.GetPrivileges($UserRightsAssignment)
        } catch {
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                Write-Error "Could not get privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
                return
            } else {
                Write-Warning -Message "Get-UserRightsAssignement - Could not get privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
            }
        }
    }
    try {
        $LsaWrapper.Dispose()
    } catch {
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            Write-Error "Could not dispose LsaWrapper. Error: $($_.Exception.Message)"
            return
        } else {
            Write-Warning -Message "Get-UserRightsAssignement - Could not dispose LsaWrapper. Error: $($_.Exception.Message)"
            return
        }
    }
}