$SoftwareInstallChrome = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/GoogleChromeStandaloneEnterprise64.msi'
$SoftwareInstall7zip = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/7z1604-x64.msi'
$SoftwareInstallJava = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/jre1.8.0_26164.msi'
$SoftwareInstallZoomFile = 'https://github.com/Ray-MRQ/MRQ/raw/master/Install%20files/ZoomInstallerFull.msi'
$SoftwareInstallAdobeReader = 'https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EcRWAKSO321GgevynQeMUzkBpZ-6wm-kHKs7_uScUdfZmw?e=4bhFXR&download=1'
$Office365Install = 'https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/Office_Install.ps1'
Write-Output ''
Write-Output "Starting download and install for 7Zip, Java, Chrome & Adobe Reader..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $SoftwareInstallChrome -outfile c:\temp\downloads\chrome.msi -Verbose
Invoke-WebRequest $SoftwareInstall7zip -outfile c:\temp\downloads\7zip.msi -Verbose
Invoke-WebRequest $SoftwareInstallJava -outfile c:\temp\downloads\java.msi -Verbose
Invoke-WebRequest $SoftwareInstallAdobeReader -outfile c:\temp\downloads\adobereader.zip -Verbose
Expand-Archive -LiteralPath c:\temp\downloads\adobereader.zip -DestinationPath c:\temp\downloads\ 
$ProgressPreference = 'Continue'
Start-Process msiexec.exe -Wait -ArgumentList '/i c:\temp\downloads\chrome.msi /qn /norestart allusers=2'
Start-Process msiexec.exe -Wait -ArgumentList '/i c:\temp\downloads\7zip.msi /qn /norestart allusers=2'
Start-Process msiexec.exe -Wait -ArgumentList '/i c:\temp\downloads\java.msi /qn /norestart allusers=2'
Start-Process msiexec.exe -Wait -ArgumentList '/i c:\temp\downloads\adobereader\acroread.msi /qn /norestart allusers=2'
Write-Output ''
Write-Output "Installed 7zip, Java, Chrome and Adobe reader silently."
Write-Output ''
exit