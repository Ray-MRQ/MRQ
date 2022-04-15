If(-not(Get-InstalledModule RunAsUser -ErrorAction silentlycontinue)){
    Install-Module RunAsUser -Confirm:$False -Force
}

$checkscript = {
if (test-path "$env:localappdata\Programs\collaborate-evolution\Horizon Collaborate.exe") {
    Copy-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Horizon Collaborate.lnk" "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup\Horizon.lnk" -Force
} else {
    set-content c:\temp\horizon_not_installed.txt notinstalled
}}

invoke-ascurrentuser -scriptblock $checkscript

$Check = test-path c:\temp\horizon_not_installed.txt

if($Check -eq "true") {
    write-host '<-Start Result->'
    Write-Host "STATUS='Horizon Collobrate' not installed."
    write-host '<-End Result->'
    $Link = $env:horizondownload
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest $Link -outfile "c:\temp\Horizon.exe"
    $ProgressPreference = 'Continue'
    $scriptblock = {C:\temp\Horizon.exe} 
    invoke-ascurrentuser -scriptblock $scriptblock
    Start-Sleep -Seconds 30
    Remove-Item c:\temp\Horizon.exe -force > $null 2>&1
    Remove-Item c:\temp\horizon_not_installed.txt -force > $null 2>&1
    Exit 1
} else {
    write-host '<-Start Result->'
    Write-Host "STATUS='Horizon Collobrate' installed."
    write-host '<-End Result->'
    Start-Sleep -Seconds 30
    Remove-Item c:\temp\horizon_not_installed.txt -force > $null 2>&1
    Remove-Item c:\temp\Horizon.exe -force > $null 2>&1
    Exit 0
}
