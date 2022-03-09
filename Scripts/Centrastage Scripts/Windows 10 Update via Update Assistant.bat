@echo off
powershell -c "mkdir c:\temp"
powershell -c "invoke-webrequest "https://go.microsoft.com/fwlink/?LinkID=799445" -OutFile c:\temp\update.exe"
powershell -c Start-Process -FilePath "c:\temp\update.exe" -ArgumentList '/quietinstall /skipeula /auto upgrade /copylogs $dir'
echo Automatically starting update now, PC will auto reboot once it has completed.