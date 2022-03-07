function write-DRRMAlert ($message) {
    write-host '<-Start Result->'
    write-host "Alert=$message"
    write-host '<-End Result->'
}

######################################

$LatestOS = $ENV:LatestBuild
$WindowsVerison = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentBuild
$OS = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").DisplayVersion

if($LatestOS -le $WindowsVerison) {
    write-DRRMAlert "Healthy: $OS"
    exit 0
} else {
    write-DRRMAlert "Unhealthy: $OS"
    Exit 1
}