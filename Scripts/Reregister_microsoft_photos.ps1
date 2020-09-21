$Photos = Get-AppxPackage Microsoft.Windows.Photos -allusers | select PackageFullName | findstr /B Microsoft*
Add-AppxPackage -register "C:\Program Files\WindowsApps\$Photos\AppxManifest.xml" -DisableDevelopmentMode
echo "This only works if the photos app has only be uninstalled by one user or if the app hasn't been removed provisoned packages."
pause