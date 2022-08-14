## Changelog

## 0.0.10 - 2022.08.14
- Improvements to speed processing

## 0.0.9 - 2022.08.14
- Using library dot sourcing instead of ScriptsToProcess

## 0.0.8 - 2022.08.14
- Improvements to speed processing

## 0.0.7 - 2022.07.19
- Fixes `Set-SecurityPolicy`

## 0.0.6 - 2022.06.15
- Fixes `Get-SecurityPolicy/Set-SecurityPolicy`

## 0.0.5 - 2022.05.22
- Added `Set-SecurityPolicy` using secedit.exe to set the security policy.
- Added `Get-SecurityPolicy` using secedit.exe to read the current security policy.
- Small changes to `Add-UserRightsAssignement` and `Remove-UserRightsAssignement` changing `Failed` to `Failure`

## 0.0.4 - 2022.05.21
- Fixes `Set-UserRightsAssignment` output when `DoNothing` is shown.

## 0.0.3 - 2022.05.21
- Improved `WhatIf` for `Add-UserRightsAssignement` and `Remove-UserRightsAssignement` operations

## 0.0.2 - 2022.05.19
- Fixes small issues with SID conversion
- Improved conversions of identities
- Added `Set-UserRightsAssignment`
- Fixed cmdlet names (I can't type)

## 0.0.1 - 2022.04.14
- Initial release
