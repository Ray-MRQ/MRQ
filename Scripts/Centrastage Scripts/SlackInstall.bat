@echo off
echo Starting Slack download and install
powershell -c "Invoke-Webrequest https://slack.com/ssb/download-win64-msi -outfile .\Slack.msi"
.\slack.msi /quiet /norestart allusers=2
echo Done, sending shortcut to desktop.
copy "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Slack Technologies\Slack.lnk" "C:\Users\Public\Desktop\Slack.lnk"