Add-Type -AssemblyName System.Windows.Forms

$V3LicenceKey = Read-Host "Enter CDM V3 License Key."
$CDMAppName = "Cloud Drive Mapper"
$CDMV3Installer = "https://iacm1gblcor1res1prod.blob.core.windows.net/release/CloudDriveMapper.msi"
$CDMInstaller = "C:\ProgramData\ONL\CloudDriveMapper.msi"
$DotNetInstallerURL = "https://share.onlinesupport.co.uk/Software/windowsdesktop-runtime-8.0.15-win-x64.exe"
$DotNetInstaller = "C:\ProgramData\ONL\dotNETRuntime8.exe"

New-Item -Path "C:\ProgramData\ONL" -ItemType Directory -ErrorAction SilentlyContinue
Start-Transcript -Path "C:\ProgramData\ONL\CDMManualDeployment.txt"

$ProgressPreference = 'SilentlyContinue'

Install-PackageProvider -Name NuGet -Force | Out-Null
Import-Module PackageManagement

if (-not $V3LicenceKey) {
    [System.Windows.Forms.MessageBox]::Show("Error: V3 Licence Key not entered. Script will now stop.", "Missing Input", "OK", "Error")
    Stop-Transcript | Out-Null
    return
}

Write-Host "Starting install procedure for Cloud Drive Mapper V3."
Write-Host "License key being used: $V3LicenceKey"

$NETFRAMEWORK8 = "Microsoft Windows Desktop Runtime - 8*"
$Check = Get-Package -Name $NETFRAMEWORK8 -ErrorAction SilentlyContinue

if ($Check) {
    Write-Host "`n$NETFRAMEWORK8 is installed."
} else {
    Write-Host "`n$NETFRAMEWORK8 is not installed, attempting to install now."
    Write-Host "Downloading installer from $DotNetInstallerURL"

    $downloadTime = Measure-Command {
        Invoke-WebRequest -Uri $DotNetInstallerURL -OutFile $DotNetInstaller
    }
    Write-Host "Download completed in: $($downloadTime.TotalSeconds) seconds"

    if (Test-Path $DotNetInstaller) {
        $installTime = Measure-Command {
            Start-Process -FilePath $DotNetInstaller -ArgumentList "/install /quiet /norestart" -Wait
        }
        Write-Host "Installation completed in: $($installTime.TotalSeconds) seconds"
    } else {
        [System.Windows.Forms.MessageBox]::Show("Failed to download .NET Runtime installer. Script will stop.", "Download Failed", "OK", "Error")
        Stop-Transcript | Out-Null
        return
    }

    $Check = Get-Package -Name $NETFRAMEWORK8 -ErrorAction SilentlyContinue
    if ($Check) {
        Write-Host "`n$NETFRAMEWORK8 is installed."
    } else {
        MSG * "Cloud Drive Mapper has failed to upgrade to the latest version, please restart your machine and the installation should be re-tried and upgraded. If not resolved, please log a support ticket - Online Support"
        [System.Windows.Forms.MessageBox]::Show("Installation of .NET 8 failed. A reboot is required before retrying this script.", "Installation Failed", "OK", "Warning")
        Stop-Transcript | Out-Null
        return
    }
}

$CDMV3Version = "3.0.0"
$Installed = Get-Package -ProviderName "MSI" -Name $CDMAppName -ErrorAction SilentlyContinue
$InstalledVersion = $Installed | Select-Object -ExpandProperty Version

if ($Installed) {
    if ($CDMV3Version -le $InstalledVersion) {
        Write-Host ''
        Write-Host "V3 Installation detected: $CDMAppName $InstalledVersion, this will be upgraded."
    } else {
        Write-Host ''
        Write-Host "V2 Installation detected: $CDMAppName $InstalledVersion, this will be removed and upgraded."
        Write-Host ''

        Stop-Process -Name "CloudDriveMapper" -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "Cloud Drive Mapper" -Force -ErrorAction SilentlyContinue

        foreach ($software in $CDMAppName) {
            Get-Package "$software" -ErrorAction SilentlyContinue | Uninstall-Package
        }

        $Installed = Get-Package -ProviderName "MSI" -Name $CDMAppName -ErrorAction SilentlyContinue

        if ($Installed) {
            [System.Windows.Forms.MessageBox]::Show("Cloud Drive Mapper V2 is still installed and must be removed manually before proceeding.", "Uninstall Failed", "OK", "Error")
            Stop-Transcript | Out-Null
            return
        } else {
            Write-Host ''
            Write-Host "V2 Installation has been successfully removed."
        }
    }
}

Write-Host ''
Write-Host "Downloading V3 installer."
$downloadTime = Measure-Command {
    Invoke-WebRequest $CDMV3Installer -OutFile $CDMInstaller
}
Write-Host "Download completed in: $($downloadTime.TotalSeconds) seconds"

if (Test-Path $CDMInstaller) {
    Write-Host ''
    Write-Host "Installing CDM V3."
    Write-Host ''
    $installResult = Measure-Command {
        $process = Start-Process msiexec.exe -PassThru -Wait -ArgumentList "/i $CDMInstaller LICENSEKEY=$V3LicenceKey LAUNCHCDM=1"
        $exitCode = $process.ExitCode
    }

    Write-Host "Installation completed in: $($installResult.TotalSeconds) seconds"

    if ($exitCode -eq 0) {
        Write-Host "Installation successful."
        $Check = Get-Package $CDMAppName -ErrorAction SilentlyContinue

        if ($Check) {
            Write-Host ''
            Write-Host "$CDMAppName is installed."
            Write-Host ''
            $Check
            [System.Windows.Forms.MessageBox]::Show("Cloud Drive Mapper V3 has been installed successfully.", "Success", "OK", "Info")
            Stop-Transcript | Out-Null
            return
        } else {
            [System.Windows.Forms.MessageBox]::Show("CDM installation finished, but the application was not detected after install.", "Verification Failed", "OK", "Warning")
            Stop-Transcript | Out-Null
            return
        }
    }

    if ($exitCode -eq 1603 -or $exitCode -eq 1618) {
        [System.Windows.Forms.MessageBox]::Show("Installation failed with code $exitCode. A reboot is required before retrying.", "Installation Error", "OK", "Warning")
        Stop-Transcript | Out-Null
        return
    } else {
        [System.Windows.Forms.MessageBox]::Show("Installation failed with exit code $exitCode.", "Installer Error", "OK", "Error")
        Stop-Transcript | Out-Null
        return
    }
} else {
    [System.Windows.Forms.MessageBox]::Show("CDM Installer was not downloaded correctly. Cannot continue.", "Missing Installer", "OK", "Error")
    Stop-Transcript | Out-Null
    return
}
