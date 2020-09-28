# Just a cheat sheet for useful stuff I've found.

# Add options for batch scripts. 
```
:begin
echo Select a task:
echo =============
echo -
echo 1) Turn on UAC
echo 2) Use Dimmed UAC
echo 3) Turn off UAC

echo.
echo.

set /P c=Choose a option:

if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3

:op1

whatever command

:op2 
whatever command 
if you want loopback

goto :begin
```
# Multiple choice powershell 

```
do { $myInput = (Read-Host 'Bla bla? (Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
'branch for yes'
} 
if ($myinput -eq 'n') {
'branch for no'
}
```
# Creates a empty output for a command.
`> $null 2>&1 hide output with this`

# Find a specifc text to use

`findstr /?`

# Create a app list to do commands etc. Example 
```
$AppList = "Microsoft.SkypeApp",          
           "Microsoft.ZuneMusic",
           "Microsoft.ZuneVideo",
           "Microsoft.Office.OneNote",
           "Microsoft.BingFinance"
ForEach ($App in $AppList)
 {
 $PackageFullName = (Get-AppxPackage $App -allusers).PackageFullName
 $ProPackageFullName = (Get-AppxProvisionedPackage -online | where {$_.Displayname -eq $App}).PackageName
 write-host $PackageFullName
 Write-Host $ProPackageFullName
 if ($PackageFullName)
 {
 Write-Host "Removing Package: $App"
 remove-AppxPackage -package $PackageFullName 
 }
 if ($ProPackageFullName)
 {
 Write-Host "Removing Provisioned Package: $ProPackageFullName"
 Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName -allusers
 }
 }
 ```
 
 # Powershell permission check
 ```
    $ver = $host | select version
    if ($ver.Version.Major -gt 1)  {$Host.Runspace.ThreadOptions = "ReuseThread"}
    # Verify that user running script is an administrator
    $IsAdmin=[Security.Principal.WindowsIdentity]::GetCurrent()
    If ((New-Object Security.Principal.WindowsPrincipal $IsAdmin).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) -eq $FALSE)
    {
      "`nERROR: You are NOT an administrator.  Run this script after using Run As administrator."
      pause
        exit
    }
```
# Batch permission check
```
goto check_Permissions

:check_Permissions
    echo Administrative permissions required. 
	echo -----------------------------------------
	echo Detecting permissions...
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
		echo -------------------------------------
    ) else (
        echo Failure: Current permissions inadequate.
		echo -------------------------------------
		echo Run as administrator and try again.
		pause
		exit
    )
```

# Elevate powershell script to administrator

```
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
```

# Elevate batch script to administrator

```
net file 1>nul 2>nul && goto :run || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof
:run
```

# Surpess progress bar (Slows down download speed using Invoke-WebRequest)

```
$ProgressPreference = 'SilentlyContinue'
#################
$ProgressPreference = 'Continue'
```

# Send an email via SMTP on Powershell

```
$EmailFrom = "from@from.com"
$EmailTo = "to@to.com"  # 
$Subject = "Some great subject line"
$Body = "Some great body section"
$SMTPServer = "smtp.some.server"
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 25)
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("username", "password");
$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
```