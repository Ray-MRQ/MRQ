function write-DRMMDiag ($messages) {
    write-host  '<-Start Diagnostic->'
    foreach ($Message in $Messages) { $Message }
    write-host '<-End Diagnostic->'
} 

function write-DRRMAlert ($message) {
    write-host '<-Start Result->'
    write-host "Alert=$message"
    write-host '<-End Result->'
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

function InstallUpdateChoco {
    Try {
        iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
        choco.exe upgrade all -y
        write-DRRMAlert "Healthy: All installed apps updated"
        Exit 0 
        }
    Catch {
        write-DRMMDiag $($_.Exception.Message)
        write-DRRMAlert "Unhealthy: Check Diagonstic info."
        exit 1
    }
}

InstallUpdateChoco
