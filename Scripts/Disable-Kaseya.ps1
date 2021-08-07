# Stop the Service and changed to service to disabled.
function Write-Alert {
    param([string]$Alert)
    Write-Host $Alert
    exit 1
}

$UDF = "Custom19"
$KaseyaService = Get-Service -displayname Kaseya* 
write-host $KaseyaService.name

foreach ($activePID in $KaseyaService ) {
    Stop-Service -Name $KaseyaService.name -passthru | Set-Service -StartupType disabled
    Write-Host "Stopped and disabled Kaseya."
    New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Kaseya disabled on this server."
} 
else { 
Write-alert "This machine has no Kaseya."
$
}

# Starts the service
# Start-Service -Name $KaseyaService.Name -passthru | Set-Service -Startup Automatic