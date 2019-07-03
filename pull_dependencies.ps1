$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path C:\dev\pull_dependencies_log.txt -append

cd c:\dev

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

cd c:\dev
if (!(Test-Path "c:\dev\rep")) { mkdir rep }

cd c:\dev\rep
if (!(Test-Path "c:\dev\rep\lamure-externals")) {

cd c:\dev\rep
if (!(Test-Path "c:\dev\rep\externals_versioning")){
mkdir externals_versioning
}

cd c:\dev\rep\externals_versioning
if (!(Test-Path "c:\dev\rep\externals_versioning\lamure-externals")) {
git clone https://github.com/vrsys/lamure-externals
} else {
cd c:\dev\rep\externals_versioning\lamure-externals
git pull origin master
}

7z x -o'c:\dev\rep\externals_versioning\lamure-externals' -mmt=8 'c:\dev\rep\externals_versioning\lamure-externals\lamure-externals_vc141_x64_zip.zip'
7z x -o'c:\dev\rep\' -mmt=8 'c:\dev\rep\externals_versioning\lamure-externals\lamure-externals_vc141_x64.zip'

Rename-Item -Path 'c:\dev\rep\lamure-externals_vc141_x64' -newName 'c:\dev\rep\lamure-externals'

git clone https://github.com/ubawurinna/freetype-windows-binaries
}

if (!(Test-Path "c:\dev\rep\guacamole-externals")) {

cd c:\dev\rep
if (!(Test-Path "c:\dev\rep\externals_versioning")){
mkdir externals_versioning
}

cd c:\dev\rep\externals_versioning
if (!(Test-Path "c:\dev\rep\externals_versioning\guacamole-externals")) {
git clone https://github.com/vrsys/guacamole-externals
} else {
cd c:\dev\rep\externals_versioning\guacamole-externals
git pull origin master
}

7z x -o'c:\dev\rep\externals_versioning\guacamole-externals' -mmt=8 'c:\dev\rep\externals_versioning\guacamole-externals\guacamole_externals_vc141_x64_zip.zip'
7z x -o'c:\dev\rep\guacamole_externals_vc141_x64' -mmt=8 'c:\dev\rep\externals_versioning\guacamole-externals\guacamole_externals_vc141_x64.zip'

Rename-Item -Path 'c:\dev\rep\guacamole_externals_vc141_x64' -newName 'c:\dev\rep\guacamole-externals'
}

if (!(Test-Path "c:\dev\rep\avango-externals")) {

cd c:\dev\rep
if (!(Test-Path "c:\dev\rep\externals_versioning")){
mkdir externals_versioning
}

cd c:\dev\rep\externals_versioning
if (!(Test-Path "c:\dev\rep\externals_versioning\avango-externals")) {
git clone https://github.com/vrsys/avango-externals
} else {
cd c:\dev\rep\externals_versioning\avango-externals
git pull origin master
}

7z x -o'c:\dev\rep\externals_versioning\avango-externals' -mmt=8 'c:\dev\rep\externals_versioning\avango-externals\avango_externals_vc141_x64_zip.zip'
7z x -o'c:\dev\rep\avango_externals_vc141_x64' -mmt=8 'c:\dev\rep\externals_versioning\avango-externals\avango_externals_vc141_x64.zip'

Rename-Item -Path 'c:\dev\rep\avango_externals_vc141_x64' -newName 'c:\dev\rep\avango-externals'
}

cd C:\

Stop-Transcript