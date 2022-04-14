function Get-UserRightsAssignement {
    [cmdletBinding()]
    param(
        [SecurityEditor.UserRightsAssignment] $UserRightsAssignment,
        [alias('ComputerName')][string] $Computer
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
    try {
        $LsaWrapper.GetPrivileges($UserRightsAssignment)
    } catch {
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            Write-Error "Could not get privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
            return
        } else {
            Write-Warning -Message "Get-UserRightsAssignement - Could not get privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
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
            Write-Warning -Message "Get-UserRightsAssignement - Could not dispose LsaWrapper. Error: $($_.Exception.Message)"
            return
        }
    }
}