function write-DRRMAlert ($message) {
    write-host '<-Start Result->'
    write-host "Alert=$message"
    write-host '<-End Result->'
}

$DattoSoftware = "$env:software"

$Installed = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*,
                 HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName | Where -Property Displayname -match $DattoSoftware


if($Installed) {
    write-DRRMAlert "'$DattoSoftware' is installed"
    Exit 0
    } else {
    write-DRRMAlert "'$DattoSoftware' is not installed" 
    Exit 1
    }