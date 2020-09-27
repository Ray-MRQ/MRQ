@echo off

net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run

cls
echo If your having trouble, download the file manually store in c:\temp and then run this again.
echo "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EWjxSgJkryRAh3Pe3l8sGlsBqdWV1N1h6URgBhCvkdsmeg?e=0hcgyh&download=1"
pause
cls
mkdir c:\temp
bitsadmin /transfer myDownloadJob /download /priority normal "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EWjxSgJkryRAh3Pe3l8sGlsBqdWV1N1h6URgBhCvkdsmeg?e=0hcgyh&download=1" c:\temp\setup_new_machine.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}"
powershell c:\temp\setup_new_machine.ps1
cls
echo Only press enter if you are done.
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Restricted -Force}"
pause
del c:\temp\setup_new_machine.ps1
exit

