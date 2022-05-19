function Set-UserRightsAssignement {
    <#
    .SYNOPSIS
    Overwrites current user rights assignment with the specified identities.

    .DESCRIPTION
    Overwrites current user rights assignment with the specified identities.
    It does so by adding only missing rights, and removing the ones that require removal.
    Identies that don't require changing are left as is.

    .PARAMETER UserRightsAssignment
    Choose user rights assignment

    .PARAMETER Computer
    Choose computer name. If not specified, the current computer will be used.

    .PARAMETER Identity
    Provide the identities to set the user rights assignment for

    .PARAMETER Suppress
    Suppress the output. By default returns the identity what happend as an object.

    .EXAMPLE
    $Identity = @(
        'BUILTIN\Backup Operators'
        'BUILTIN\Administrators'
        'Guest'
        'BUILTIN\Users'
        'przemyslaw.klys'
    )

    Set-UserRightsAssignement -UserRightsAssignment SeBackupPrivilege -Identity $Identity -WhatIf

    .NOTES
    General notes
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory, ParameterSetName = 'UserRights')][LocalSecurityEditor.UserRightsAssignment] $UserRightsAssignment,
        [alias('ComputerName')][string] $Computer,
        [alias('UserName')][string[]] $Identity,
        [switch] $Suppress
    )
    $ToDo = [ordered] @{}
    $WhatHappend = [ordered] @{}

    $ConvertedIdentities = foreach ($I in $Identity) {
        Convert-Identity -Identity $I
    }

    $CurrentSettings = Get-UserRightsAssignement -UserRightsAssignment $UserRightsAssignment -Computer $Computer

    foreach ($I in $ConvertedIdentities.Name) {
        if ($I -in $CurrentSettings.Name) {
            $ToDo[$I] = 'DoNothing'
        } else {
            $ToDo[$I] = 'Add'
        }
    }
    foreach ($I in $CurrentSettings.Name) {
        if ($I -notin $ConvertedIdentities.Name) {
            $ToDo[$I] = 'Remove'
        }
    }

    foreach ($Action in $ToDo.Keys) {
        if ($ToDo[$Action] -eq 'Add') {
            $DidItWork = Add-UserRightsAssignement -UserRightsAssignment $UserRightsAssignment -Computer $Computer -Identity $Action
            $WhatHappend[$Action] = $DidItWork
        } elseif ($ToDo[$Action] -eq 'Remove') {
            $DidItWork = Remove-UserRightsAssignement -UserRightsAssignment $UserRightsAssignment -Computer $Computer -Identity $Action
            $WhatHappend[$Action] = $DidItWork
        } elseif ($ToDo[$Action] -eq 'DoNothing') {
            $WhatHappend[$Action] = [PSCustomObject] @{
                "Action"               = 'Nothing'
                "Identity"             = $ConvertedIdentity.Name
                'SID'                  = $ConvertedIdentity.Sid
                "UserRightsAssignment" = $UserRightsAssignment
                "Status"               = 'NoAction'
                "Error"                = ''
            }
        }
    }
    if (-not $Suppress) {
        $WhatHappend
    }
}