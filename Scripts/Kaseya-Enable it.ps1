$UDF = "Custom19"
$KaseyaService = Get-Service -displayname Kaseya* 
$service = Get-Service $KaseyaService.name 

foreach ($activePID in $KaseyaService ) {
    Get-Service -displayname Kaseya* | Set-Service -StartupType Automatic
    Start-Service -Name $KaseyaService.name
    $service2 = Get-Service $KaseyaService.name 
    if ($service.status -eq "Running") {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Kaseya is enabled on this server."}
    if ($service.status -eq "Stopped") {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Kaseya is stopped/not running"}
    Write-Host "Started and enabled Kaseya."
}


If (Get-Service $service -ErrorAction SilentlyContinue) {

} Else {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Kaseya is not installed on this machine"}