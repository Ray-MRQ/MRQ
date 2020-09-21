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
} else {
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