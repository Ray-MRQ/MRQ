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