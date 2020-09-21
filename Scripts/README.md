# Just a cheat sheet for useful stuff I've found.

# Add options for batch scripts. 
```
echo off
:begin
echo Select a task:
echo =============
echo -
echo 1) Option 1
echo 2) Option 2

echo -
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2

echo Please Pick an option:
goto begin


:op1
echo you picked option 1
goto begin

:op2
echo you picked option 2
goto begin

:exit
@exit
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