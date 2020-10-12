if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
mkdir c:\temp
powershell -command Invoke-WebRequest "https://github.com/Ray-MRQ/MRQ/raw/master/Scripts/BuildScript.ps1" -outfile c:\temp\BuildScript.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}"
powershell c:\temp\BuildScript.ps1
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Restricted -Force}"
Remove-Item c:\temp\BuildScript.ps1
exit