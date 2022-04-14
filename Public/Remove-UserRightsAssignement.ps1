function Remove-UserRightsAssignement {
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

    .EXAMPLE
    Remove-UserRightsAssignement -UserRightsAssignment SeBackupPrivilege -Identity "Evotec\Administrator"

    .NOTES
    General notes
    #>
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory)][LocalSecurityEditor.UserRightsAssignment] $UserRightsAssignment,
        [alias('ComputerName')][string] $Computer,
        [parameter(Mandatory)][alias('UserName')][string] $Identity
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