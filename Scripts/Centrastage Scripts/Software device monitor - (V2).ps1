$DattoSoftware = "$env:software"
$DattoVersion = "$env:SoftwareVersion"

$Installed = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*,
                 HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion | Where -Property Displayname -match $DattoSoftware
$InstalledVersion = $Installed | Select-Object -ExpandProperty DisplayVersion

function VersionCheck {

if($DattoVersion -eq $InstalledVersion) {
    write-host '<-Start Result->'
    Write-Host "STATUS='$DattoSoftware' is up to date."
    write-host '<-End Result->'
    Exit 0
    } else {
    write-host '<-Start Result->'
    Write-Host "STATUS='$DattoSoftware' is not up to date" 
    write-host '<-End Result->'
    Exit 1
    }}

If($installed) {
    VersionCheck
} else {
    write-host '<-Start Result->'
    write-host "STATUS='$DattoSoftware' is not installed."
    write-host '<-End Result->'
    Exit 1
}

# Input variables are Software and $SoftwareVersion from Datto
