@echo off
net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run

echo.
echo  ____  __    _____    __   ____  _    _    __    ____  ____    ____  ____  __  __  _____  _  _  __    __   
echo (  _ \(  )  (  _  )  /__\ (_  _)( \/\/ )  /__\  (  _ \( ___)  (  _ \( ___)(  \/  )(  _  )( \/ )/__\  (  )  
echo  ) _ ( )(__  )(_)(  /(__)\  )(   )    (  /(__)\  )   / )__)    )   / )__)  )    (  )(_)(  \  //(__)\  )(__ 
echo (____/(____)(_____)(__)(__)(__) (__/\__)(__)(__)(_)\_)(____)  (_)\_)(____)(_/\/\_)(_____)  \/(__)(__)(____)
echo.
echo Dell Bloatware Removal Version 1.0
echo.
echo.
:Start
::Pause
echo Running removal tool now, please wait...

START /WAIT /MIN WMIC product where name="Dell Power Manager Service" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="Dell Mobile Connect Drivers" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="Dell SupportAssist Remediation" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="SmartByte Drivers and Services" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="Dell Update - SupportAssist Update Plugin" call uninstall /nointeractive

Echo Begin removal via GUID 

::DellPowerManager
start /wait msiexec /qn /norestart /x {18469ED8-8C36-4CF7-BD43-0FC9B1931AF8}

::Dell Mobile Connect
start /wait msiexec /qn /norestart /x {2D27B76E-8FB1-495B-A61D-FB76349E7E36}

::Dell Update Support assist
start /wait msiexec /qn /norestart /x {75F60BB7-09E9-4555-BFF0-D1B6102A33DE}

::Dell Update support assist update plugin
start /wait msiexec /qn /norestart /x {B336B590-DB14-438C-A473-2ECD4E193BFC}