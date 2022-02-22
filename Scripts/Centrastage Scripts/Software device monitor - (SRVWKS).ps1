$SoftwareWKS = "$env:workstationsoftware"
$SoftwareSRV = "$env:serversoftware"

$MachineType = (Get-ComputerInfo).OsProductType

if($MachineType -eq "Workstation") {
echo $machinetype
$Installed = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*,
                 HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName | Where -Property Displayname -match $softwareWKS
If($installed -match "$SoftwareWKS") {
	write-host '<-Start Result->'
 	Write-Host "STATUS='$SoftwareWKS' is installed."
 	write-host '<-End Result->'
     exit 0
} else {
	write-host '<-Start Result->'
 	write-host "STATUS='$SoftwareWKS' is not installed."
 	write-host '<-End Result->'
     exit 1
}} else {
echo $machinetype
$Installed = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*,
                 HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName | Where -Property Displayname -match $softwareSRV
If($installed -match "$SoftwareSRV") {
	write-host '<-Start Result->'
 	Write-Host "STATUS='$SoftwareSRV' is installed."
 	write-host '<-End Result->'
     exit 0
} else {
	write-host '<-Start Result->'
 	write-host "STATUS='$SoftwareSRV' is not installed."
     exit 1
}}

#Input variables WorkstationSoftware and SeverSoftware for Datto. 
