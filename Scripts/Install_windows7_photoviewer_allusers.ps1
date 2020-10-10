if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
Invoke-WebRequest "https://github.com/Ray-MRQ/MRQ/raw/master/Regkeys_xmls/Undo_Restore_Windows_Photo_Viewer_ALL_USERS.reg" -outfile c:\temp\Photoviewer.reg
Invoke-Command {reg import C:\temp\Photoviewer.reg *>&1 | Out-Null}
Remove-Item "c:\temp\photoviewer.reg"
Write-Output "Recommended to restart after running the script, check the photo viewer is installed via open with on a compataible image file. Make sure to change default app to this."
pause