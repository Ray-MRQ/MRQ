echo "Starting download and installing Dropbox silently"
Invoke-Webrequest "https://www.dropbox.com/download?full=1&plat=win" -outfile .\Dropbox.exe -UseBasicParsing
.\dropbox.exe /s
echo "Completed install."