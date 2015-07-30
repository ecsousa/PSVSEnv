
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
    param([string] $envVar, $batFile)

    if(-not(Test-Path Env:$envVar)) {
        Write-Warning "Environment variable $envVar is undefined"
        return;
    }

    $vsvars32FullPath = Join-Path (Get-Item Env:$envVar).Value $batFile

    if(-not(Test-Path $vsvars32FullPath)) {
        Write-Warning "Could not find file '$vsvars32FullPath'";
        return;
    }

    Write-Verbose "Importing Visual Studio environment variables from '$vsvars32FullPath'";

    Import-Env $vsvars32FullPath
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
    Set-VSEnv 'VS100COMNTOOLS' 'vsvars32.bat'
}

[CmdletBinding]
function Set-VS2012 {
    Set-VSEnv 'VS110COMNTOOLS' 'vsvars32.bat'
}

[CmdletBinding]
function Set-VS2013 {
    Set-VSEnv 'VS120COMNTOOLS' 'vsvars32.bat'
}

[CmdletBinding]
function Set-VS2015 {
    Set-VSEnv 'VS140COMNTOOLS' 'VsDevCmd.bat'
}

Set-Alias vs2010 Set-VS2010
Set-Alias vs2012 Set-VS2012
Set-Alias vs2013 Set-VS2013
Set-Alias vs2015 Set-VS2015
Set-Alias waik Set-WAIK

Export-ModuleMember -Function `
    Set-VS2010,
    Set-VS2012,
    Set-VS2013,
    Set-VS2015,
    Set-WAIK

Export-ModuleMember -Alias `
    vs2010,
    vs2012,
    vs2013,
    vs2015,
    waik

