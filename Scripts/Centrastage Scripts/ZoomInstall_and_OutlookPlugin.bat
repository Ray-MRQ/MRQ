@echo off
powershell -c "Invoke-Webrequest https://zoom.us/client/latest/ZoomInstallerFull.msi -outfile .\ZoomInstall.msi"
start /wait /i .\ZoomInstall.msi /qn
powershell -c "Invoke-Webrequest https://zoom.us/client/latest/ZoomOutlookPluginSetup.msi -outfile .\ZoomOutlookPlugin.msi"
start /wait /i .\ZoomOutlookPlugin.msi /qn