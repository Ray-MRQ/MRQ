$uninstall = $env:uninstall

Install-PackageProvider -Name NuGet -Force -MinimumVersion 2.8.5.208 > $null 2>&1

foreach ($software in $uninstall) {
Get-Package "$software" -ErrorAction SilentlyContinue | Uninstall-Package
Write-Host "Unintalled $Software."
}