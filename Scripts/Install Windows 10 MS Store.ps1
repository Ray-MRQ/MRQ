#Download links
$NetFramework = "https://github.com/onladmin/BuildScripts/raw/master/Install%20files/Windows10Store/Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe.Appx"
$NetRuntime = "https://github.com/onladmin/BuildScripts/raw/master/Install%20files/Windows10Store/Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe.Appx"
$VCLibs = "https://github.com/onladmin/BuildScripts/raw/master/Install%20files/Windows10Store/Microsoft.VCLibs.140.00_14.0.29231.0_x64__8wekyb3d8bbwe.Appx"
$Store = "https://github.com/onladmin/BuildScripts/raw/master/Install%20files/Windows10Store/Microsoft.WindowsStore_12101.1001.1413.0_neutral_~_8wekyb3d8bbwe.AppxBundle"

Write-Host "Make sure this is running as user context."


$dir = 'c:\temp\downloads\'
Remove-Item c:\temp\downloads\ -recurse -force > $null 2>&1
mkdir $dir > $null 2>&1


Invoke-WebRequest $NetFramework -outfile c:\temp\downloads\netframework.Appx
Invoke-WebRequest $NetRuntime -outfile c:\temp\downloads\netruntime.Appx
Invoke-WebRequest $VCLibs -outfile c:\temp\downloads\vclibs.Appx
Invoke-WebRequest $Store -outfile c:\temp\downloads\store.AppxBundle

Add-AppPackage c:\temp\downloads\netframework.Appx
Add-AppPackage c:\temp\downloads\netruntime.Appx
Add-AppPackage c:\temp\downloads\vclibs.Appx
Add-AppPackage c:\temp\downloads\store.AppxBundle

Write-Host "Installation is now completed, please give it a couple seconds to be useable."