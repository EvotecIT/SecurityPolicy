function Add-UserRightsAssignement {
    <#
    .SYNOPSIS
    Add identity object to the specified user rights assignement role.

    .DESCRIPTION
    Add identity object to the specified user rights assignement role.

    .PARAMETER UserRightsAssignment
    Choose user rights assignment

    .PARAMETER Computer
    Choose computer name. If not specified, the current computer will be used.

    .PARAMETER Identity
    Choose identity object by providing it's full name

    .EXAMPLE
    Add-UserRightsAssignement -UserRightsAssignment SeBackupPrivilege -Identity "Evotec\Administrator"

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