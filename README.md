# PSVSEnv

PowerShell module for loading Visual Studio Environment variables. It provides the following function:

* `Set-VS2010`: Loads environment variables for Visual Studio 2010
* `Set-VS2012`: Loads environment variables for Visual Studio 2012
* `Set-VS2013`: Loads environment variables for Visual Studio 2013
* `Set-VS2015`: Loads environment variables for Visual Studio 2015
* `Set-VS2017`: Loads environment variables for Visual Studio 2017
* `Set-WAIK`: Loads environment variables for Windows Automated Instaltion Kit

This module also provides two aliases:

* `vs2010`: alias to `Set-VS2010`
* `vs2012`: alias to `Set-VS2012`
* `vs2013`: alias to `Set-VS2013`
* `vs2015`: alias to `Set-VS2015`
* `vs2017`: alias to `Set-VS2017`
* `waik`: alias to `Set-WAIK`

Note: each one of these functions needs the related software installed.

## Installing

Windows 10 users:

    Install-Module PSVSEnv -Scope CurrentUser

Otherwise, if you have [PsGet](http://psget.net/) installed:


    Install-Module PSVSEnv
  
Or you can install it manually coping `PSVSEnv.psm1` to your modules folder (e.g. ` $Env:USERPROFILE\Documents\WindowsPowerShell\Modules\PSVSEnv\`)

