@echo off

net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run

cls
mkdir c:\temp
powershell -command Invoke-WebRequest "https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/Setup_new_machine.ps1" -outfile c:\temp\setup_new_machine.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}"
powershell c:\temp\setup_new_machine.ps1
pause
cls
echo Only press enter if you are done.
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Restricted -Force}"
pause
del c:\temp\setup_new_machine.ps1
exit