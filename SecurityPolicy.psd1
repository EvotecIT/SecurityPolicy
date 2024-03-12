@{
    AliasesToExport      = @()
    Author               = 'Przemyslaw Klys'
    CmdletsToExport      = @()
    CompanyName          = 'Evotec'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2011 - 2024 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Module that allows getting, adding and removing User Rights Assignment without using secedit.exe'
    FunctionsToExport    = @('Add-UserRightsAssignment', 'Get-SecurityPolicy', 'Get-UserRightsAssignment', 'Remove-UserRightsAssignment', 'Set-SecurityPolicy', 'Set-UserRightsAssignment')
    GUID                 = '0e3eaa53-5e0b-4f10-9375-d6a0a9a1eb45'
    ModuleVersion        = '0.0.14'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            ProjectUri = 'https://github.com/EvotecIT/SecurityPolicy'
            Tags       = @('Windows', 'Secedit', 'Policies', 'UserRightsAssignment')
        }
    }
    RequiredModules      = @(@{
            Guid          = 'ee272aa8-baaa-4edf-9f45-b6d6f7d844fe'
            ModuleName    = 'PSSharedGoods'
            ModuleVersion = '0.0.280'
        })
    RootModule           = 'SecurityPolicy.psm1'
}