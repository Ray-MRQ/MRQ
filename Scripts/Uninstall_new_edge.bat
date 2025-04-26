@echo off

net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run

echo Please confirm you would like New Microsoft Edge to be removed.
pause

rmdir /q /s "C:\Program Files (x86)\Microsoft\Edge"
rmdir /q /s "C:\Program Files (x86)\Microsoft\EdgeUpdate"
rmdir /q /s "C:\Program Files (x86)\Microsoft\Temp"
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"
del "C:\Users\Public\Desktop\Microsoft Edge.lnk"
cls

echo This should now remove the new edge, you might need to delete from the Recyle bin as well
pause