function Get-UserRightsAssignment {
    <#
    .SYNOPSIS
    Provides a list of users assigned to a specific role.

    .DESCRIPTION
    Provides a list of users assigned to a specific role.

    .PARAMETER UserRightsAssignment
    Choose the role to list the users assigned to.

    .PARAMETER Computer
    Choose computer name. If not specified, the current computer will be used.

    .PARAMETER All
    Get all users for all user rights assignment for the specified computer.

    .EXAMPLE
    Get-UserRightsAssignment -All

    .EXAMPLE
    Get-UserRightsAssignment -UserRightsAssignment SeBackupPrivilege

    .NOTES
    General notes
    #>
    [cmdletBinding(DefaultParameterSetName = 'UserRights')]
    param(
        [parameter(Mandatory, ParameterSetName = 'UserRights')][LocalSecurityEditor.UserRightsAssignment] $UserRightsAssignment,
        [alias('ComputerName')][string] $Computer,
        [parameter(ParameterSetName = 'All')][switch] $All
    )

    try {
        if ($Computer) {
            $LsaWrapper = [LocalSecurityEditor.LsaWrapper]::new($Computer)
        } else {
            $LsaWrapper = [LocalSecurityEditor.LsaWrapper]::new()
        }
    } catch {
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            Write-Error "Could not create LsaWrapper. Error: $($_.Exception.Message)"
            return
        } else {
            Write-Warning -Message "Get-UserRightsAssignment - Could not create LsaWrapper. Error: $($_.Exception.Message)"
            return
        }
    }
    if ($All) {
        $Output = [ordered] @{}
        $EnumValues = [Enum]::GetNames([LocalSecurityEditor.UserRightsAssignment])
        foreach ($Value in $EnumValues | Sort-Object) {
            try {
                $PriviligeOutput = $LsaWrapper.GetPrivileges($Value)
            } catch {
                $PriviligeOutput = $null
                if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                    Write-Error "Could not get privileges for $Value. Error: $($_.Exception.Message)"
                    return
                } else {
                    Write-Warning -Message "Get-UserRightsAssignment - Could not get privileges for $Value. Error: $($_.Exception.Message)"
                }
            }
            $Output[$Value] = foreach ($P in $PriviligeOutput) {
                Convert-Identity -Identity $P
            }
        }
        $Output
    } else {
        try {
            $PriviligeOutput = $LsaWrapper.GetPrivileges($UserRightsAssignment)
        } catch {
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                Write-Error "Could not get privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
                return
            } else {
                Write-Warning -Message "Get-UserRightsAssignment - Could not get privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
            }
        }
        foreach ($P in $PriviligeOutput) {
            Convert-Identity -Identity $P
        }
    }
    try {
        $LsaWrapper.Dispose()
    } catch {
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            Write-Error "Could not dispose LsaWrapper. Error: $($_.Exception.Message)"
            return
        } else {
            Write-Warning -Message "Get-UserRightsAssignment - Could not dispose LsaWrapper. Error: $($_.Exception.Message)"
            return
        }
    }
}