Function Get-SecurityPolicy {
    <#
    .SYNOPSIS
    Get security policy settings being read from Local Security Policy using secedit.exe

    .DESCRIPTION
    Get security policy settings being read from Local Security Policy using secedit.exe

    .PARAMETER ConfigFile
    Optional path to the config file to use. If not specified, the temp config file will be used.

    .PARAMETER All
    Get all settings from all sections

    .PARAMETER SystemAccess
    Get specific setting from System Access section

    .PARAMETER EventAudit
    Get specific setting from Event Audit section

    .EXAMPLE
    Get-SecurityPolicy -Verbose -All

    .EXAMPLE
    Get-SecurityPolicy -SystemAccess LockoutBadCount

    .EXAMPLE
    Get-SecurityPolicy -SystemAccess MinimumPasswordLength

    .NOTES
    General notes
    #>
    [CmdletBinding(DefaultParameterSetName = 'SystemAccess')]
    param(
        [string] $ConfigFile = "$env:TEMP\security.cfg",
        [Parameter(ParameterSetName = 'All')][switch] $All,
        [Parameter(Mandatory, ParameterSetName = 'SystemAccess')][ValidateSet(
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

        [Parameter(Mandatory, ParameterSetName = 'EventAudit')][ValidateSet(
            'AuditSystemEvents'            , # 0
            'AuditLogonEvents'             , # 0
            'AuditObjectAccess'            , # 0
            'AuditPrivilegeUse'            , # 0
            'AuditPolicyChange'            , # 0
            'AuditAccountManage'           , # 0
            'AuditProcessTracking'         , # 0
            'AuditDSAccess'                , # 0
            'AuditAccountLogon'              # 0
        )][string] $EventAudit
    )
    if (Test-Path -LiteralPath $ConfigFile -ErrorAction SilentlyContinue) {
        Remove-Item -LiteralPath $ConfigFile -Force
    }
    $pinfo = [System.Diagnostics.ProcessStartInfo]::new()
    $pinfo.FileName = "secedit.exe"
    $pinfo.RedirectStandardError = $true
    $pinfo.RedirectStandardOutput = $true
    $pinfo.UseShellExecute = $false
    $pinfo.Arguments = "/export /cfg `"$ConfigFile`""
    $p = [System.Diagnostics.Process]::new()
    $p.StartInfo = $pinfo
    $p.Start() | Out-Null
    $p.WaitForExit()
    $Output = $p.StandardOutput.ReadToEnd().Trim()
    #$Errors = $p.StandardError.ReadToEnd()

    if ($Output -like "*task has completed successfully*") {
        $SecurityPolicy = [ordered] @{}
        $index = 0
        if (Test-Path -LiteralPath $ConfigFile -ErrorAction SilentlyContinue) {
            try {
                $contents = Get-Content -LiteralPath $ConfigFile -Raw -ErrorAction Stop
                [regex]::Matches($contents, "(?<=\[)(.*)(?=\])") | ForEach-Object {
                    $title = $_
                    [regex]::Matches($contents, "(?<=\]).*?((?=\[)|(\Z))", [System.Text.RegularExpressions.RegexOptions]::Singleline)[$index] | ForEach-Object {
                        $section = [ordered] @{}
                        $_.value -split "\r\n" | Where-Object { $_.length -gt 0 } | ForEach-Object {
                            $value = [regex]::Match($_, "(?<=\=).*").value
                            $name = [regex]::Match($_, ".*(?=\=)").value
                            $section[$name.tostring().trim()] = $value.tostring().trim()
                        }
                        $SecurityPolicy[$Title.Value] = $Section
                    }
                    $index += 1
                }
            } catch {
                if ($PSBoundParameters.ErrorAction -eq 'Stop') {
                    throw
                } else {
                    Write-Warning -Message "Failed to export security policy. Error: $($_.Exception.Message)"
                }
            }
        }
        if ($All) {
            $SecurityPolicy
        } elseif ($SystemAccess) {
            [PSCustomObject] @{
                Name  = $SystemAccess
                Value = $SecurityPolicy['System Access'].$SystemAccess
            }
        } elseif ($EventAudit) {
            [PSCustomObject] @{
                Name  = $EventAudit
                Value = $SecurityPolicy['Event Audit'].$EventAudit
            }
        }
    } else {
        if ($PSBoundParameters.ErrorAction -eq 'Stop') {
            throw $Output
        } else {
            Write-Warning -Message "Failed to export security policy. Error: $($Output)"
        }
    }
}