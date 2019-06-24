@echo off

echo.
echo Welcome to VRSYS deployment container. Please, run one of the following deployment scripts:
echo.
echo .\install_dev.ps1 for complete development stack of lamure/guacamole/avango
echo.
echo .\pull_dependencies.ps1 to get the latest state of dependencies
echo .\pull_repositories.ps1 to get the latest state of repositories
echo .\build_repositories.ps1 to make BUILD and INSTALL targets of the application stack
echo.

C:\BuildTools\Common7\Tools\VsDevCmd.bat