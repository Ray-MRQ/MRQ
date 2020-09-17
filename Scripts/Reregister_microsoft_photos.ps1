Get-AppxPackage Microsoft.Windows.Photos -allusers | select PackageFullName
echo "------------------------------------------------------------"
echo "Note down the above it is the package name for photo viewer"
echo "------------------------------------------------------------"
echo "Copy this line powershell command and adjust as needed (not that if you have a diffirent \Microsoft.Photos.XX then change it to the package name above)"
echo "------------------------------------------------------------"
echo "Add-AppxPackage -register C:\Program Files\WindowsApps\Microsoft.Windows.Photos_16.302.8200.0_x64__8wekyb3d8bbwe\AppxManifest.xml -DisableDevelopmentMode"
echo "You need to add speach marks for the file path since it's got a space in it"
pause