# CloudDriveMapper_Install.ps1 - Installs Cloud Drive Mapper V3 or V3TS
# Version 1.5

param (
    [string]$CDMV3LicenceKey,
    [string]$LicenceKey,
    [string]$CDMVersion = "V3"
)

$CDMAppName = "Cloud Drive Mapper"
$CDMV3Installer = "https://iacm1gblcor1res1prod.blob.core.windows.net/release/CloudDriveMapper.msi"
$CDMInstaller = "CloudDriveMapper.msi"
$V3BatchURL = "https://share.onlinesupport.co.uk/Software/CloudDriveMapper/StartCDMV3.bat"
$V3XMLURL = "https://share.onlinesupport.co.uk/Software/CloudDriveMapper/StartCDM.xml"
$BatchFile = "StartCDMV3.bat"
$XMLFile = "StartCDM.xml"
$CDMV3Version = "3.0.0"
$ProgressPreference = 'SilentlyContinue'
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

Remove-Item -Path "C:\ProgramData\CentraStage\ONL\CDMDeployment.txt" -Force -ErrorAction SilentlyContinue

# Resolve license key from either Datto or Intune
$ResolvedKey = if ($CDMV3LicenceKey) { $CDMV3LicenceKey } elseif ($LicenceKey) { $LicenceKey } else { $null }

if (-not $ResolvedKey) {
    Write-Host "`nError: No license key provided. Provide either CDMV3LicenceKey (Datto) or LicenceKey (Intune). Exiting."
    $LASTEXITCODE = 1
    Exit 1
}

Install-PackageProvider -Name NuGet -Force | Out-Null
Import-Module PackageManagement

# Check .NET Runtime 8
$NETFRAMEWORK8 = "Microsoft Windows Desktop Runtime - 8*"
$Check = Get-Package -Name $NETFRAMEWORK8 -ErrorAction SilentlyContinue
if (-not $Check) {
    Write-Host "`n$NETFRAMEWORK8 is not installed."
    $LASTEXITCODE = 1
    Exit 1
} else {
    Write-Host "`n$NETFRAMEWORK8 is installed."
}

# Check existing CDM install
$Installed = Get-Package -ProviderName "MSI" -Name $CDMAppName -ErrorAction SilentlyContinue
$InstalledVersion = $Installed | Select-Object -ExpandProperty Version -ErrorAction SilentlyContinue
if (-not $InstalledVersion) { $InstalledVersion = "0.0.0" }

if ($Installed) {
    if ($CDMV3Version -le $InstalledVersion) {
        Write-Host "`n$CDMAppName version $InstalledVersion is installed. Proceeding with upgrade."
    } else {
        Write-Host "`nOlder version detected: $InstalledVersion. Removing before upgrade..."
        Stop-Process -Name "CloudDriveMapper" -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "Cloud Drive Mapper" -Force -ErrorAction SilentlyContinue
        Get-Package -Name $CDMAppName -ErrorAction SilentlyContinue | Uninstall-Package -Force -ErrorAction SilentlyContinue

        Start-Sleep -Seconds 5
        $Installed = Get-Package -ProviderName MSI -Name $CDMAppName -ErrorAction SilentlyContinue
        if ($Installed) {
            Write-Host "$CDMAppName V2 is still installed. Exiting."
            $Installed
            $LASTEXITCODE = 1
            Exit 1
        } else {
            Write-Host "V2 installation successfully removed."
        }
    }
}

# Download installer
Write-Host "`nDownloading installer from $CDMV3Installer"
$downloadTime = Measure-Command {
    Invoke-WebRequest $CDMV3Installer -OutFile $CDMInstaller
}
Write-Host "Download completed in $($downloadTime.TotalSeconds) seconds."

if (-not (Test-Path $CDMInstaller)) {
    Write-Host "`nInstaller file not found. Aborting."
    $LASTEXITCODE = 1
    Exit 1
}

# Install CDM
Write-Host "`nInstalling CDM $CDMVersion..."
$exitCode = $null
$installTime = Measure-Command {
    $process = Start-Process msiexec.exe -PassThru -Wait -ArgumentList "/i $CDMInstaller /qn LICENSEKEY=$ResolvedKey LAUNCHCDM=1"
    $exitCode = $process.ExitCode
}
Write-Host "Installation completed in $($installTime.TotalSeconds) seconds."

Remove-Item $CDMInstaller -Force -ErrorAction SilentlyContinue

if ($exitCode -eq 0) {
    Write-Host "Installation successful."

    if ($CDMVersion -eq "V3TS") {
        Remove-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Cloud Drive Mapper.lnk" -ErrorAction SilentlyContinue
        New-Item -ItemType Directory -Path "C:\CDM" -ErrorAction SilentlyContinue | Out-Null

        Write-Host "`nDownloading batch file from $V3BatchURL"
        Invoke-WebRequest $V3BatchURL -OutFile $BatchFile
        if (-not (Test-Path $BatchFile)) {
            Write-Host "Failed to download batch file. Exiting."
            $LASTEXITCODE = 1
            Exit 1
        }

        Write-Host "Downloading XML file from $V3XMLURL"
        Invoke-WebRequest $V3XMLURL -OutFile $XMLFile
        if (-not (Test-Path $XMLFile)) {
            Write-Host "Failed to download XML file. Exiting."
            $LASTEXITCODE = 1
            Exit 1
        }

        Copy-Item $BatchFile "C:\CDM\StartCDM.bat" -Force
        schtasks /create /xml $XMLFile /tn "StartCDM"
    }

    $Check = Get-Package $CDMAppName -ErrorAction SilentlyContinue
    if ($Check) {
        Write-Host "`n$CDMAppName is installed."
        $Check
        $LASTEXITCODE = 0
        Exit 0
    } else {
        Write-Host "`n$CDMAppName is not installed after installation."
        $LASTEXITCODE = 1
        Exit 1
    }

} elseif ($exitCode -eq 1603 -or $exitCode -eq 1618) {
    try {
        $session = quser | Select-String "Active" -ErrorAction Stop
        if ($session -and $CDMVersion -eq "V3") {
            MSG * "Cloud Drive Mapper failed to upgrade. Please restart your machine. If the issue persists, contact Online Support."
        }
    } catch {
        Write-Host "No interactive session to display message."
    }

    Write-Host "Installation failed with exit code: $exitCode"
    $LASTEXITCODE = $exitcode
    Exit $exitCode
} else {
    Write-Host "Installation failed with exit code: $exitCode"
    $LASTEXITCODE = $exitcode
    Exit $exitCode
}
