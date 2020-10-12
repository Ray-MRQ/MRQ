@echo off

net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run

cls
mkdir c:\temp
powershell -command Invoke-WebRequest "https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/BuildScript.ps1" -outfile c:\temp\BuildScript.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}"
powershell c:\temp\BuildScript.ps1
cls
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Restricted -Force}"
del c:\temp\BuildScript.ps1
exit