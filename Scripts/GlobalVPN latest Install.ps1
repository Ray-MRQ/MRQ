mkdir c:\temp > $null 2>&1
$LatestGlobalVPN = "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EYZvOaEVIEtBukk9zYczYLwBQLs9jkuim6q0zO9l5legUQ?e=A7IwAd"


##################UNINSTALLS ANY PRE-EXISTING INSTALLSTIONS########################

###########################UNINSTALL############################
echo "Uninstalling 4.9.9 if it exists."
Start-Process msiexec -wait -argumentlist "/X {0E14625B-DF56-4657-8678-DFD1955BE97A} /qn /norestart"
echo "Uninstalling 4.10.2 if it exists."
Start-Process msiexec -wait -argumentlist "/X {7D7ED176-EA00-4B2B-B421-AA19A451F650} /qn /norestart"
############################INSTALL#############################
echo "Starting GlobalVPN silent install"
Invoke-Webrequest "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/EYZvOaEVIEtBukk9zYczYLwBQLs9jkuim6q0zO9l5legUQ?e=A7IwAd&download=1" -outfile c:\temp\GVCInstall64.msi
Start-Process msiexec -wait -argumentlist '/i c:\temp\GVCInstall64.msi /qn /norestart' 
netsh advfirewall firewall add rule name="SonicWall Global VPN Client" dir=in action=allow program="C:\program files\sonicwall\global vpn client\swgvc.exe" enable=yes
Copy-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Global VPN Client.lnk" "C:\Users\Public\Desktop\Global VPN Client.lnk"
echo Completed. 
pause