$OS = [System.Environment]::OSVersion.Version 
$UDF = "Custom13"

if ($OS -match 6003) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 7 / Windows Server 2008 (Build 7601)"}
if ($OS -match 7601) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 7 SP1 / Windows Server 2008 R2 (Build 7601)"}
if ($OS -match 9200) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 8 / Windows Server 2012 (Build 9200)"}
if ($OS -match 9600) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows 8.1 / Windows Server 2012 R2 (Build 9600)"}
if ($OS -match 19043) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Build Version 21H1 (Build 19043)"}
if ($OS -match 19042) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Build Version 20H2 (Build 19042)"}
if ($OS -match 19041) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Build Version 2004 (Build 19041)"}
if ($OS -match 18363) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Build Version 1909 (Build 18363)"}
if ($OS -match 18362) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Build Version 1903 (Build 18362)"}
if ($OS -match 17763) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Build Version 1809 (Build 17763)"}
if ($OS -match 17134) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Build Version 1803 (Build 17134)"}
if ($OS -match 16299) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Build Version 1709 (Build 16299)"}
if ($OS -match 15063) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Build Version 1703 (Build 15063)"}
if ($OS -match 14393) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Build Version 1607 (Build 14393)"}
if ($OS -match 10586) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Build Version 1511 (Build 10586)"}
if ($OS -match 10240) {New-ItemProperty -Path HKLM:\SOFTWARE\CentraStage\ -Name $UDF -PropertyType String -Value "Windows Build Version 1507 (Build 10240)"}

Write-Output "If there is not a REG key edit above then this script failed."