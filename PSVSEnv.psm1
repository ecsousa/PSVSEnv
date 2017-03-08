
function Import-Env {
    param([string] $batFile)

    $cmd = "`"$batFile`" & set"
    cmd /c $cmd | Foreach-Object {
        $p, $v = $_.split('=')
        Set-Item -path env:$p -value $v
    }
}

[CmdletBinding]
function Set-VSEnv {
    param($vsvars32FullPath)

    if(-not(Test-Path $vsvars32FullPath)) {
        Write-Warning "Could not find file '$vsvars32FullPath'";
        return;
    }

    Write-Verbose "Importing Visual Studio environment variables from '$vsvars32FullPath'";

    Import-Env $vsvars32FullPath
}

[CmdletBinding]
function Set-VSEnvComnTools {
    param([string] $envVar, $batFile)

    if(-not(Test-Path Env:$envVar)) {
        Write-Warning "Environment variable $envVar is undefined"
        return;
    }

    $vsvars32FullPath = Join-Path (Get-Item Env:$envVar).Value $batFile

    Set-VSEnv $vsvars32FullPath
}

[CmdletBinding]
function Set-VSEnvVSWhere {
    param([string] $version, $batFile)

    $vsPath = & "$PSScriptRoot\vswhere.exe" -version $version -property installationPath

    if(-not($vsPath)) {
        Write-Warning "Could not find Visual Studio installation path for version '$version'"
        return;
    }

    $vsvars32FullPath = Join-Path $vsPath $batFile

    Set-VSEnv $vsvars32FullPath
}

[CmdletBinding]
function Set-WAIK {
    $pesetenvFullPath = "C:\Program Files\Windows AIK\Tools\PETools\pesetenv.cmd"

    if(-not(Test-Path $pesetenvFullPath)) {
        Write-Warning "Could not find pesetenv.cmd"
        return;
    }

    Write-Verbose "Importing Windows AIK environment";

    Import-Env $pesetenvFullPath
}

[CmdletBinding]
function Set-VS2010 {
    Set-VSEnvComnTools 'VS100COMNTOOLS' 'vsvars32.bat'
}

[CmdletBinding]
function Set-VS2012 {
    Set-VSEnvComnTools 'VS110COMNTOOLS' 'vsvars32.bat'
}

[CmdletBinding]
function Set-VS2013 {
    Set-VSEnvComnTools 'VS120COMNTOOLS' 'vsvars32.bat'
}

[CmdletBinding]
function Set-VS2015 {
    Set-VSEnvComnTools 'VS140COMNTOOLS' 'VsDevCmd.bat'
}

[CmdletBinding]
function Set-VS2017 {
    Set-VSEnvVSWhere '[15.0,16.0)' 'Common7\Tools\VsDevCmd.bat'
}


Set-Alias vs2010 Set-VS2010
Set-Alias vs2012 Set-VS2012
Set-Alias vs2013 Set-VS2013
Set-Alias vs2015 Set-VS2015
Set-Alias vs2017 Set-VS2017
Set-Alias waik Set-WAIK

