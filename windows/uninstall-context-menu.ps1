# PowerShell script to remove "Open in Cursor" from Windows context menu
# This script requires administrator privileges
# Run this script with: PowerShell -ExecutionPolicy Bypass -File uninstall-context-menu.ps1

# Check if running as Administrator
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "This script requires administrator privileges." -ForegroundColor Red
    Write-Host "Please run PowerShell as Administrator and try again." -ForegroundColor Yellow
    exit 1
}

Write-Host "Removing 'Open in Cursor' from context menu..." -ForegroundColor Yellow

# Registry paths to remove
$registryPaths = @(
    "Registry::HKEY_CLASSES_ROOT\Directory\shell\OpenInCursor",
    "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\OpenInCursor",
    "Registry::HKEY_CLASSES_ROOT\*\shell\OpenInCursor"
)

foreach ($path in $registryPaths) {
    if (Test-Path $path) {
        Remove-Item -Path $path -Recurse -Force
        Write-Host "Removed: $path" -ForegroundColor Cyan
    } else {
        Write-Host "Not found: $path" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "Successfully removed 'Open in Cursor' from context menu!" -ForegroundColor Green
