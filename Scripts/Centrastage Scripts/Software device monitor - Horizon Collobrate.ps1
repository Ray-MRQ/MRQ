If(-not(Get-InstalledModule RunAsUser -ErrorAction silentlycontinue)){
    Install-Module RunAsUser -Confirm:$False -Force
}
mkdir c:\software > $null 2>&1

$checkscript = {
Copy-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Horizon Collaborate.lnk" "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup\Horizon.lnk" -Force
test-path $env:localappdata\Programs\collaborate-evolution
}

$Check = invoke-ascurrentuser -scriptblock $checkscript

if($Check -eq "true") {
write-host '<-Start Result->'
Write-Host "STATUS='Horizon Collobrate' installed."
write-host '<-End Result->'
Start-Sleep -Seconds 30
Remove-Item c:\software\Horizon.exe -force > $null 2>&1
Exit 0
} else {
write-host '<-Start Result->'
Write-Host "STATUS='Horizon Collobrate' not installed."
write-host '<-End Result->'
Start-Sleep -Seconds 30
$Link = $env:horizondownload
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest $Link -outfile "c:\software\Horizon.exe"
$ProgressPreference = 'Continue'
$scriptblock = {
If(test-path $env:localappdata\Programs\collaborate-evolution) {} else {C:\software\Horizon.exe}} 
invoke-ascurrentuser -scriptblock $scriptblock
Remove-Item c:\software\Horizon.exe -force > $null 2>&1
Exit 1
}
