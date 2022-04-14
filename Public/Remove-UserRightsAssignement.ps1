function Remove-UserRightsAssignement {
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
            Write-Warning -Message "Remove-UserRightsAssignement - Could not create LsaWrapper. Error: $($_.Exception.Message)"
            return
        }
    }
    if ($PSCmdlet.ShouldProcess("Removing $Identity from $UserRightsAssignment", 'Add-UserRightsAssignement')) {
        try {
            $LsaWrapper.RemovePrivileges($Identity, $UserRightsAssignment)
        } catch {
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                Write-Error "Could not remove privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
                return
            } else {
                Write-Warning -Message "Remove-UserRightsAssignement - Could not remove privileges for $UserRightsAssignment. Error: $($_.Exception.Message)"
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
            Write-Warning -Message "Remove-UserRightsAssignement - Could not dispose LsaWrapper. Error: $($_.Exception.Message)"
            return
        }
    }
}