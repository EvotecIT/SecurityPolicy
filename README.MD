# SecurityPolicy - PowerShell Module

<p align="center">
  <a href="https://dev.azure.com/evotecpl/SecurityPolicy/_build/latest?definitionId=3"><img src="https://img.shields.io/azure-devops/build/evotecpl/a5ce5d3e-9ae2-49a0-9905-53eb41205fc9/7?label=Azure%20Pipelines&style=flat-square"></a>
  <a href="https://www.powershellgallery.com/packages/SecurityPolicy"><img src="https://img.shields.io/powershellgallery/v/SecurityPolicy.svg?style=flat-square"></a>
  <a href="https://www.powershellgallery.com/packages/SecurityPolicy"><img src="https://img.shields.io/powershellgallery/vpre/SecurityPolicy.svg?label=powershell%20gallery%20preview&colorB=yellow&style=flat-square"></a>
  <a href="https://github.com/EvotecIT/SecurityPolicy"><img src="https://img.shields.io/github/license/EvotecIT/SecurityPolicy.svg?style=flat-square"></a>

</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/SecurityPolicy"><img src="https://img.shields.io/powershellgallery/p/SecurityPolicy.svg?style=flat-square"></a>
  <a href="https://github.com/EvotecIT/SecurityPolicy"><img src="https://img.shields.io/github/languages/top/evotecit/SecurityPolicy.svg?style=flat-square"></a>
  <a href="https://github.com/EvotecIT/SecurityPolicy"><img src="https://img.shields.io/github/languages/code-size/evotecit/SecurityPolicy.svg?style=flat-square"></a>
  <a href="https://www.powershellgallery.com/packages/SecurityPolicy"><img src="https://img.shields.io/powershellgallery/dt/SecurityPolicy.svg?style=flat-square"></a>
</p>

<p align="center">
  <a href="https://twitter.com/PrzemyslawKlys"><img src="https://img.shields.io/twitter/follow/PrzemyslawKlys.svg?label=Twitter%20%40PrzemyslawKlys&style=flat-square"></a>
  <a href="https://evotec.xyz/hub"><img src="https://img.shields.io/badge/Blog-evotec.xyz-2A6496.svg?style=flat-square"></a>
  <a href="https://www.linkedin.com/in/pklys"><img src="https://img.shields.io/badge/LinkedIn-pklys-0077B5.svg?logo=LinkedIn&style=flat-square"></a>
</p>

## Description

Provides a way to configure **user rights assignments** in local security policies using PowerShell without using `secedit.exe`.

### Supported User Rights Assignement

| Group Policy Setting                                               | Constant Name                             |
| ------------------------------------------------------------------ | ----------------------------------------- |
| Access Credential Manager as a trusted caller                      | SeTrustedCredManAccessPrivilege           |
| Access this computer from the network                              | SeNetworkLogonRight                       |
| Act as part of the operating system                                | SeTcbPrivilege                            |
| Add workstations to domain                                         | SeMachineAccountPrivilege                 |
| Adjust memory quotas for a process                                 | SeIncreaseQuotaPrivilege                  |
| Allow log on locally                                               | SeInteractiveLogonRight                   |
| Allow log on through Remote Desktop Services                       | SeRemoteInteractiveLogonRight             |
| Back up files and directories                                      | SeBackupPrivilege                         |
| Bypass traverse checking                                           | SeChangeNotifyPrivilege                   |
| Change the system time                                             | SeSystemtimePrivilege                     |
| Change the time zone                                               | SeTimeZonePrivilege                       |
| Create a pagefile                                                  | SeCreatePagefilePrivilege                 |
| Create a token object                                              | SeCreateTokenPrivilege                    |
| Create global objects                                              | SeCreateGlobalPrivilege                   |
| Create permanent shared objects                                    | SeCreatePermanentPrivilege                |
| Create symbolic links                                              | SeCreateSymbolicLinkPrivilege             |
| Debug programs                                                     | SeDebugPrivilege                          |
| Deny access to this computer from the network                      | SeDenyNetworkLogonRight                   |
| Deny log on as a batch job                                         | SeDenyBatchLogonRight                     |
| Deny log on as a service                                           | SeDenyServiceLogonRight                   |
| Deny log on locally                                                | SeDenyInteractiveLogonRight               |
| Deny log on through Remote Desktop Services                        | SeDenyRemoteInteractiveLogonRight         |
| Enable computer and user accounts to be trusted for delegation     | SeEnableDelegationPrivilege               |
| Force shutdown from a remote system                                | SeRemoteShutdownPrivilege                 |
| Generate security audits                                           | SeAuditPrivilege                          |
| Impersonate a client after authentication                          | SeImpersonatePrivilege                    |
| Increase a process working set                                     | SeIncreaseWorkingSetPrivilege             |
| Increase scheduling priority                                       | SeIncreaseBasePriorityPrivilege           |
| Load and unload device drivers                                     | SeLoadDriverPrivilege                     |
| Lock pages in memory                                               | SeLockMemoryPrivilege                     |
| Log on as a batch job                                              | SeBatchLogonRight                         |
| Log on as a service                                                | SeServiceLogonRight                       |
| Manage auditing and security log                                   | SeSecurityPrivilege                       |
| Modify an object label                                             | SeRelabelPrivilege                        |
| Modify firmware environment values                                 | SeSystemEnvironmentPrivilege              |
| Obtain an impersonation token for another user in the same session | SeDelegateSessionUserImpersonatePrivilege |
| Perform volume maintenance tasks                                   | SeManageVolumePrivilege                   |
| Profile single process                                             | SeProfileSingleProcessPrivilege           |
| Profile system performance                                         | SeSystemProfilePrivilege                  |
| Remove computer from docking station                               | SeUndockPrivilege                         |
| Replace a process level token                                      | SeAssignPrimaryTokenPrivilege             |
| Restore files and directories                                      | SeRestorePrivilege                        |
| Shut down the system                                               | SeShutdownPrivilege                       |
| Synchronize directory service data                                 | SeSyncAgentPrivilege                      |
| Take ownership of files or other objects                           | SeTakeOwnershipPrivilege                  |

### Installing

```powershell
Install-Module -Name SecurityPolicy -AllowClobber -Force
```

Force and AllowClobber aren't necessary but they do skip errors in case some appear.

### Updating

```powershell
Update-Module -Name SecurityPolicy
```

That's it. Whenever there's a new version you simply run the command and you can enjoy it. Remember, that you may need to close, reopen the PowerShell session if you have already used the module before updating it.

**The important thing** is if something works for you on production, keep using it till you test the new version on a test computer. I do changes that may not be big, but big enough that auto-update will break your code. For example, small rename to a parameter and your code stops working! Be responsible!