function Set-SecurityPolicy {
    <#
    .SYNOPSIS
    Set security policy ssetting in the Local Security Policy using secedit.exe

    .DESCRIPTION
    Set security policy ssetting in the Local Security Policy using secedit.exe

    .PARAMETER SystemAccess
    Choose specific system access policy.

    .PARAMETER Value
    Set specific value for the policy.

    .PARAMETER ConfigFile
    Optional path to the config file to use. If not specified, the temp config file will be used.

    .PARAMETER Suppress
    Suppress the output. By default output is provided

    .EXAMPLE
    Set-SecurityPolicy -SystemAccess MinimumPasswordAge -Value 1 -Whatif

    .NOTES
    General notes
    #>
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][ValidateSet(
            'MinimumPasswordAge'          , #0
            'MaximumPasswordAge'          , #60
            'MinimumPasswordLength'       , #8
            'PasswordComplexity'          , #1
            'PasswordHistorySize'         , #24
            'LockoutBadCount'             , #5
            'ResetLockoutCount'           , #35
            'LockoutDuration'             , #35
            'RequireLogonToChangePassword', #0
            'ForceLogoffWhenHourExpire'   , #0
            'NewAdministratorName'        , #"Administrator"
            'NewGuestName'                , #"Guest"
            'ClearTextPassword'           , #0
            'LSAAnonymousNameLookup'      , #0
            'EnableAdminAccount'          , #1
            'EnableGuestAccount'            #0
        )][string] $SystemAccess,
        [Parameter(Mandatory)][object] $Value,
        [string] $ConfigFile = "$env:TEMP\security.cfg",
        [switch] $Suppress
    )
    if ($PSCmdlet.ShouldProcess("$SystemAccess to $Value", "Set-SecurityPolicy")) {
        try {
            $Object = Get-SecurityPolicy -ConfigFile $ConfigFile -ErrorAction Stop
        } catch {
            if (-not $Suppress) {
                [PSCustomObject] @{
                    "Name"   = $SystemAccess
                    "Value"  = $Value
                    "Status" = $false
                    "Error"  = $($_.Exception.Message)
                }
            }
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                throw
            } else {
                Write-Warning -Message "Failed to read security policy. Error: $($_.Exception.Message)"
                return
            }
        }
        if ($SystemAccess) {
            $Object.'System Access'.$SystemAccess = $Value
        }

        try {
            $Object.GetEnumerator() | ForEach-Object {
                "[$($_.Name)]"
                $_.Value | ForEach-Object {
                    $_.GetEnumerator() | ForEach-Object {
                        "$($_.Name)=$($_.Value)"
                    }
                }
            } | Out-File -LiteralPath $ConfigFile -ErrorAction Stop
        } catch {
            if (-not $Suppress) {
                [PSCustomObject] @{
                    "Name"   = $SystemAccess
                    "Value"  = $Value
                    "Status" = $false
                    "Error"  = $($_.Exception.Message)
                }
            }
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                throw
            } else {
                Write-Warning -Message "Failed to save security policy. Error: $($_.Exception.Message)"
                return
            }
        }

        $pinfo = [System.Diagnostics.ProcessStartInfo]::new()
        $pinfo.FileName = "secedit.exe"
        $pinfo.RedirectStandardError = $true
        $pinfo.RedirectStandardOutput = $true
        $pinfo.UseShellExecute = $false
        $pinfo.Arguments = " /configure /db c:\windows\security\local.sdb /cfg `"$ConfigFile`" /areas SECURITYPOLICY"
        $p = [System.Diagnostics.Process]::new()
        $p.StartInfo = $pinfo
        $p.Start() | Out-Null
        $p.WaitForExit()
        $Output = $p.StandardOutput.ReadToEnd()
        $Errors = $p.StandardError.ReadToEnd()

        if ($Output -like "*task has completed successfully*") {
            if (-not $Suppress) {
                [PSCustomObject] @{
                    "Name"   = $SystemAccess
                    "Value"  = $Value
                    "Status" = $true
                    "Error"  = ""
                }
            }
        } else {
            if (-not $Suppress) {
                [PSCustomObject] @{
                    "Name"   = $SystemAccess
                    "Value"  = $Value
                    "Status" = $false
                    "Error"  = $Errors
                }
            }
            if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                throw $Errors
            } else {
                Write-Warning -Message "Failed to save security policy. Error: $Errors"
            }
        }
    } else {

    }
}