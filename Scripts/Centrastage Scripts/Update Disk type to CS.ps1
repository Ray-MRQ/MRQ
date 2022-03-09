function write-DRMMDiag ($messages) {
    write-host  '<-Start Diagnostic->'
    foreach ($Message in $Messages) { $Message }
    write-host '<-End  Diagnostic->'
} 
function write-DRRMAlert ($message) {
    write-host '<-Start Result->'
    write-host "Alert=$message"
    write-host '<-End Result->'
}
$DiskList = @()
$Disks = Get-PhysicalDisk | Select-Object FriendlyName, MediaType,BusType
foreach($Disk in $Disks){
$Disklist += "Diskname: $($Disk.FriendlyName) MediaType: $($Disk.MediaType) Bustype:$($Disk.BusType) / "

}
New-ItemProperty "HKLM:\SOFTWARE\CentraStage" -Name "Custom22" -PropertyType string -value $Disklist -Force