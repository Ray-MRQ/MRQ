@echo off
Echo Set time to DC/Windows.Time
echo Current time is;
time/t
echo.
echo Starting script.
echo.
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters" /v Type /t reg_sz /d AllSync /f
net stop w32time
net start w32time
w32tm /query /configuration
w32tm /query /status
w32tm /resync
echo.
echo Ignore the above error if it appears, this just tests. Confirm below what the time is.
echo.
time/t
echo.
echo Completed. 