function Add-UserRightsAssignement {
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory)][SecurityEditor.UserRightsAssignment] $UserRightsAssignment,
        [alias('ComputerName')][string] $Computer,
        [parameter(Mandatory)][alias('UserName')][string] $Identity
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
            Write-Warning -Message "Add-UserRightsAssignement - Could not create LsaWrapper. Error: $($_.Exception.Message)"
            return
        }
    }
    if ($PSCmdlet.ShouldProcess("Adding $Identity to $UserRightsAssignment", 'Add-UserRightsAssignement')) {
        try {
            $LsaWrapper.AddPrivileges($Identity, $UserRightsAssignment)
        } catch {
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                Write-Error "Could not add privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
                return
            } else {
                Write-Warning -Message "Add-UserRightsAssignement - Could not add privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
                return
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
            Write-Warning -Message "Add-UserRightsAssignement - Could not dispose LsaWrapper. Error: $($_.Exception.Message)"
            return
        }
    }
}