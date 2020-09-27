@echo off

net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run

rmdir /q /s "C:\Program Files (x86)\Microsoft\Edge"
rmdir /q /s "C:\Program Files (x86)\Microsoft\EdgeUpdate"
rmdir /q /s "C:\Program Files (x86)\Microsoft\Temp"
cls

echo This should now remove the new edge, you might need to delete from the Recyle bin as well
pause