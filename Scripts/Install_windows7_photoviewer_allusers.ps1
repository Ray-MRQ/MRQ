if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
Invoke-WebRequest "https://onl-my.sharepoint.com/:u:/g/personal/mohammed_quashem_onlinesupport_co_uk/ESAYxk0w24ZDssEcyxe7CQcBncnMBOFVrC6KncyDvZUB-w?e=gixpBi&download=1" -outfile c:\temp\Photoviewer.reg
Invoke-Command {reg import C:\temp\Photoviewer.reg *>&1 | Out-Null}
Remove-Item "c:\temp\photoviewer.reg"
echo "Recommended to restart after running the script, check the photo viewer is installed via open with on a compataible image file. Make sure to change default app to this."
pause