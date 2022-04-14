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
This module is alternative to [SecurityPolicyDSC](https://github.com/dsccommunity/SecurityPolicyDsc) which uses a wrapper around secedit.exe.

### Supported User Rights Assignement

| ConstantName                              | Group Policy Setting                                               |
| ----------------------------------------- | ------------------------------------------------------------------ |
| SeTrustedCredManAccessPrivilege           | Access Credential Manager as a trusted caller                      |
| SeNetworkLogonRight                       | Access this computer from the network                              |
| SeTcbPrivilege                            | Act as part of the operating system                                |
| SeMachineAccountPrivilege                 | Add workstations to domain                                         |
| SeIncreaseQuotaPrivilege                  | Adjust memory quotas for a process                                 |
| SeInteractiveLogonRight                   | Allow log on locally                                               |
| SeRemoteInteractiveLogonRight             | Allow log on through Remote Desktop Services                       |
| SeBackupPrivilege                         | Back up files and directories                                      |
| SeChangeNotifyPrivilege                   | Bypass traverse checking                                           |
| SeSystemtimePrivilege                     | Change the system time                                             |
| SeTimeZonePrivilege                       | Change the time zone                                               |
| SeCreatePagefilePrivilege                 | Create a pagefile                                                  |
| SeCreateTokenPrivilege                    | Create a token object                                              |
| SeCreateGlobalPrivilege                   | Create global objects                                              |
| SeCreatePermanentPrivilege                | Create permanent shared objects                                    |
| SeCreateSymbolicLinkPrivilege             | Create symbolic links                                              |
| SeDebugPrivilege                          | Debug programs                                                     |
| SeDenyNetworkLogonRight                   | Deny access to this computer from the network                      |
| SeDenyBatchLogonRight                     | Deny log on as a batch job                                         |
| SeDenyServiceLogonRight                   | Deny log on as a service                                           |
| SeDenyInteractiveLogonRight               | Deny log on locally                                                |
| SeDenyRemoteInteractiveLogonRight         | Deny log on through Remote Desktop Services                        |
| SeEnableDelegationPrivilege               | Enable computer and user accounts to be trusted for delegation     |
| SeRemoteShutdownPrivilege                 | Force shutdown from a remote system                                |
| SeAuditPrivilege                          | Generate security audits                                           |
| SeImpersonatePrivilege                    | Impersonate a client after authentication                          |
| SeIncreaseWorkingSetPrivilege             | Increase a process working set                                     |
| SeIncreaseBasePriorityPrivilege           | Increase scheduling priority                                       |
| SeLoadDriverPrivilege                     | Load and unload device drivers                                     |
| SeLockMemoryPrivilege                     | Lock pages in memory                                               |
| SeBatchLogonRight                         | Log on as a batch job                                              |
| SeServiceLogonRight                       | Log on as a service                                                |
| SeSecurityPrivilege                       | Manage auditing and security log                                   |
| SeRelabelPrivilege                        | Modify an object label                                             |
| SeSystemEnvironmentPrivilege              | Modify firmware environment values                                 |
| SeDelegateSessionUserImpersonatePrivilege | Obtain an impersonation token for another user in the same session |
| SeManageVolumePrivilege                   | Perform volume maintenance tasks                                   |
| SeProfileSingleProcessPrivilege           | Profile single process                                             |
| SeSystemProfilePrivilege                  | Profile system performance                                         |
| SeUndockPrivilege                         | Remove computer from docking station                               |
| SeAssignPrimaryTokenPrivilege             | Replace a process level token                                      |
| SeRestorePrivilege                        | Restore files and directories                                      |
| SeShutdownPrivilege                       | Shut down the system                                               |
| SeSyncAgentPrivilege                      | Synchronize directory service data                                 |
| SeTakeOwnershipPrivilege                  | Take ownership of files or other objects                           |

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