$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path C:\dev\pull_repositories_log.txt -append

if (!(Test-Path "c:\dev\dep")) { mkdir dep }
cd c:\dev\dep

$env:Path += ";C:\"

if (!(Test-Path "c:\dev\dep\GitForWindows.2.21.0")) { nuget install GitForWindows -Version 2.21.0 }
if (!(Test-Path "c:\dev\dep\7-Zip.x64.16.02.1")) {  nuget install 7-Zip.x64 -Version 16.2.1 }
#if (!(Test-Path "c:\dev\dep\CMake.3.5.2")) { nuget install CMake -Version 3.5.2 }
if (!(Test-Path "c:\dev\dep\python.3.5.4")){ nuget install python -Version 3.5.4 }

$env:Path += ";C:\dev\dep\GitForWindows.2.21.0\tools\mingw64\bin"
$env:Path += ";C:\dev\dep\7-Zip.x64.16.02.1\tools"
#$env:Path += ";C:\dev\dep\CMake.3.5.2\bin"

cd c:\dev\rep
if (!(Test-Path "c:\dev\rep\lamure")) {
git clone https://github.com/vrsys/lamure
cd c:\dev\rep\lamure
} else {
cd c:\dev\rep\lamure
git pull origin master
}

cd c:\dev\rep
if (!(Test-Path "c:\dev\rep\guacamole")) {
git clone https://github.com/vrsys/guacamole
cd c:\dev\rep\guacamole
} else {
cd c:\dev\rep\guacamole
git pull origin master
}

cd c:\dev\rep
if (!(Test-Path "c:\dev\rep\avango")) {
git clone https://github.com/vrsys/avango
cd c:\dev\rep\avango
} else {
cd c:\dev\rep\avango
git pull origin master
}

cd C:\

Stop-Transcript