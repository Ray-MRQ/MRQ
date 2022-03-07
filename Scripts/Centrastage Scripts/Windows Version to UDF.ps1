$MachineType = (Get-ComputerInfo).OsProductType
$OS = [System.Environment]::OSVersion.Version.build
$UDF = "Custom13"

if($MachineType -eq "Workstation") {
if ($OS -match 22000) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 11 21H2"}
if ($OS -match 19044) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 21H2"}
if ($OS -match 19043) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 21H1"}
if ($OS -match 19042) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 20H2"}
if ($OS -match 19041) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 2004"}
if ($OS -match 18363) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 1909"}
if ($OS -match 18362) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 1903"}
if ($OS -match 17763) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 1809"}
if ($OS -match 17134) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 1803"}
if ($OS -match 16299) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 1709"}
if ($OS -match 15063) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 1703"}
if ($OS -match 14393) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 1607"}
if ($OS -match 10586) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 1511"}
if ($OS -match 10240) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 10 1507"}
} else {
if ($OS -match 20348) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Server 2022 21H2"}
if ($OS -match 17763) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Server 2019 1809"}
if ($OS -match 14393) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Server 2016 1607"}
if ($OS -match 9600) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Server 2012 R2"}
if ($OS -match 9600) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Server 2012 R2"}
if ($OS -match 9200) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Server 2012"}
if ($OS -match 7601) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Server 2008 R2"}
if ($OS -match 6003) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Server 2008"}
}
Write-Output "If there is not a REG key edit above then this script failed."