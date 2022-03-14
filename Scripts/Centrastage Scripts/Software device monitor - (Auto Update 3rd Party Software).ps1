function write-DRMMDiag ($messages) {
    write-host  '<-Start Diagnostic->'
    foreach ($Message in $Messages) { $Message }
    write-host '<-End Diagnostic->'
} 

try {
	[Net.ServicePointManager]::SecurityProtocol = [Enum]::ToObject([Net.SecurityProtocolType], 3072)
} catch [system.exception] {
    write-DRMMDiag "$($_.Exception.Message)
	write-host "- ERROR: Could not implement TLS 1.2 Support."
	write-host "  This can occur on Windows 7 devices lacking Service Pack 1."
	write-host "  Please install that before proceeding.""
	exit 1
}

Try {
        iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
        C:\ProgramData\chocolatey\choco.exe upgrade all -y
        write-host '<-Start Result->'
        Write-Host "STATUS=All installed apps updated."
        write-host '<-End Result->'
        Exit 0 
        }
Catch {
        write-DRMMDiag $($_.Exception.Message)
        write-host '<-Start Result->'
        write-host "STATUS=Issue updating apps, check diagnostic."
        write-host '<-End Result->'
        exit 1
}
