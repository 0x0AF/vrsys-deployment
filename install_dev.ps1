$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path C:\dev\build_log.txt -append

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
git clone https://github.com/0x0AF/lamure-externals
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
git clone https://github.com/0x0AF/guacamole-externals
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
git clone https://github.com/0x0AF/avango-externals
} else {
cd c:\dev\rep\externals_versioning\avango-externals
git pull origin master
}

7z x -o'c:\dev\rep\externals_versioning\avango-externals' -mmt=8 'c:\dev\rep\externals_versioning\avango-externals\avango_externals_vc141_x64_zip.zip'
7z x -o'c:\dev\rep\avango_externals_vc141_x64' -mmt=8 'c:\dev\rep\externals_versioning\avango-externals\avango_externals_vc141_x64.zip'

Rename-Item -Path 'c:\dev\rep\avango_externals_vc141_x64' -newName 'c:\dev\rep\avango-externals'
}

cd c:\dev\rep
if (!(Test-Path "c:\dev\rep\lamure")) {
git clone https://github.com/0x0AF/lamure
cd c:\dev\rep\lamure
} else {
cd c:\dev\rep\lamure
git pull origin master
}

# assuming location c:\dev\rep\lamure
if (!(Test-Path "c:\dev\rep\lamure\build")) { mkdir build }
cd build

if (!(Test-Path "c:\dev\rep\lamure\build\INSTALL.vcxproj")) {

cmake .. `
-G "Visual Studio 15 2017" -A x64 `
-DCMAKE_BUILD_TYPE=Release `
-DDEPLOYMENT_EXTERNALS=C:\dev\rep\lamure-externals `
-DCMAKE_INSTALL_PREFIX=C:\dev\rep\lamure\install `
-DGLUT_ROOT_PATH=C:\dev\rep\lamure-externals\glut `
-DBOOST_ROOT=C:\dev\rep\lamure-externals\boost

msbuild /m:8 /p:CL_MPCount=8 /p:Configuration=Release INSTALL.vcxproj

}

Copy-Item -Path C:\dev\rep\lamure-externals\schism\lib\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\lamure-externals\glew\bin\Release\x64\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\lamure-externals\zlib\bin\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\lamure-externals\FreeImage\lib\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\lamure-externals\boost\lib\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\lamure-externals\CGAL\bin\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\lamure-externals\glut\bin\x64\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\externals_versioning\freetype-windows-binaries\win64\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force

cd c:\dev\rep
if (!(Test-Path "c:\dev\rep\guacamole")) {
git clone https://github.com/0x0AF/guacamole
cd c:\dev\rep\guacamole
} else {
cd c:\dev\rep\guacamole
git pull origin master
}

# assuming location c:\dev\rep\guacamole
if (!(Test-Path "c:\dev\rep\guacamole\build")) { mkdir build }
cd build

if (!(Test-Path "c:\dev\rep\guacamole\build\INSTALL.vcxproj")) {

cmake .. `
-G "Visual Studio 15 2017" -A x64 `
-DCMAKE_BUILD_TYPE=Release `
-DDEPLOYMENT_EXTERNALS=C:\dev\rep\guacamole-externals `
-DCMAKE_INSTALL_PREFIX=C:\dev\rep\guacamole\install `
-DGUACAMOLE_ENABLE_VIRTUAL_TEXTURING=ON `
-DPLUGIN_guacamole-lod:BOOL=ON `
-DPLUGIN_guacamole-vive:BOOL=ON `
-DLAMURE_VT_ROOT=C:\dev\rep\lamure\install `
-DLAMURE_VT_LIBRARY_SEARCH_DIR=C:\dev\rep\lamure\install\lib\Release `
-DBOOST_ROOT=C:\dev\rep\guacamole-externals\boost 

# msbuild /m:8 /p:CL_MPCount=8 /p:Configuration=Release ALL_BUILD.vcxproj

msbuild /m:8 /p:CL_MPCount=8 /p:Configuration=Release INSTALL.vcxproj

}

Copy-Item -Path C:\dev\rep\lamure\install\bin\Release\*.dll -Destination C:\dev\rep\guacamole\examples\vive\Release -Force

cd c:\dev\rep
if (!(Test-Path "c:\dev\rep\avango")) {
git clone https://github.com/0x0AF/avango
cd c:\dev\rep\avango
} else {
cd c:\dev\rep\avango
git pull origin master
}

# assuming location c:\dev\rep\avango
if (!(Test-Path "c:\dev\rep\avango\build")) { mkdir build }
cd build

if (!(Test-Path "c:\dev\rep\avango\build\ALL_BUILD.vcxproj")) {

cmake .. `
-G "Visual Studio 15 2017" -A x64 `
-DCMAKE_BUILD_TYPE=Release `
-DDEPLOYMENT_EXTERNALS=C:\dev\rep\avango-externals `
-DAVANGO_VIRTUAL_TEXTURING_SUPPORT:BOOL=ON `
-DAVANGO_LOD_SUPPORT:BOOL=ON `
-DAVANGO_VIVE_SUPPORT:BOOL=ON `
-DBOOST_ROOT=C:\dev\rep\avango-externals\boost `
-DBULLET_ROOT=C:\dev\rep\avango-externals\bullet `
-DBoost_PYTHON3_LIBRARY_DEBUG=C:\dev\rep\avango-externals\boost\lib\boost_python35-vc141-mt-gd-x64-1_67.lib `
-DBoost_PYTHON3_LIBRARY_RELEASE=C:\dev\rep\avango-externals\boost\lib\boost_python35-vc141-mt-x64-1_67.lib `
-DPYTHON_INCLUDE_DIR=C:\dev\dep\python.3.5.4\tools\include `
-DPYTHON_LIBRARY=C:\dev\dep\python.3.5.4\tools\libs\python35.lib `
-DPYTHON_DEBUG_LIBRARY=C:\dev\dep\python.3.5.4\tools\libs\python35.lib

# msbuild /m:8 /p:CL_MPCount=8 /p:Configuration=Release ALL_BUILD.vcxproj

msbuild /m:8 /p:CL_MPCount=8 /p:Configuration=Release ALL_BUILD.vcxproj

}

Copy-Item -Path C:\dev\rep\avango-externals\all_dlls\*.dll -Destination C:\dev\rep\avango\lib\Release -Force
Copy-Item -Path C:\dev\rep\guacamole\examples\vive\Release\*.dll -Destination C:\dev\rep\avango\lib\Release -Force

Stop-Transcript