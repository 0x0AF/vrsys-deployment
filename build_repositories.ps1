$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path C:\dev\build_repositories_log.txt -append

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

cd c:\dev\rep\lamure
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

}

msbuild /m:8 /p:CL_MPCount=8 /p:Configuration=Release INSTALL.vcxproj

Copy-Item -Path C:\dev\rep\lamure-externals\schism\lib\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\lamure-externals\glew\bin\Release\x64\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\lamure-externals\zlib\bin\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\lamure-externals\FreeImage\lib\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\lamure-externals\boost\lib\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\lamure-externals\CGAL\bin\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\lamure-externals\glut\bin\x64\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force
Copy-Item -Path C:\dev\rep\externals_versioning\freetype-windows-binaries\win64\*.dll -Destination C:\dev\rep\lamure\install\bin\Release -Force

cd c:\dev\rep\guacamole
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

}

msbuild /m:8 /p:CL_MPCount=8 /p:Configuration=Release INSTALL.vcxproj

$files = get-childitem C:\dev\rep\guacamole\examples -Recurse -Force *.exe

foreach ($file in $files)
{
  # echo $file.Name
  # echo $file.Directory.FullName
  
  $('Copying to '+$file.Directory.FullName+'...')
  
  Copy-Item -Path C:\dev\rep\lamure\install\bin\Release\*.dll -Destination $file.Directory.FullName -Force
}

foreach ($file in $files)
{ 
  if (Test-Path "c:\dev\rep\avango\build") {
      $('Making data link in '+$file.Directory.FullName+'...')
  
      New-Item -Path $($file.Directory.FullName+'\data') -ItemType SymbolicLink -Value $($file.Directory.Parent.FullName+'\data')
  }
}

foreach ($file in $files)
{
  $('Simlinking executable folder '+$file.Directory.FullName+'...')
  
  New-Item -Path $('C:\dev\rep\guacamole\install\bin\Release\' + $file.Directory.Parent.Name) -ItemType SymbolicLink -Value $file.Directory.FullName
}

cd c:\dev\rep\avango
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

}

msbuild /m:8 /p:CL_MPCount=8 /p:Configuration=Release ALL_BUILD.vcxproj

Copy-Item -Path C:\dev\rep\avango-externals\all_dlls\*.dll -Destination C:\dev\rep\avango\lib\Release -Force
Copy-Item -Path C:\dev\rep\guacamole\examples\vive\Release\*.dll -Destination C:\dev\rep\avango\lib\Release -Force

cd C:\

Stop-Transcript