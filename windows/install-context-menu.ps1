# PowerShell script to add "Open in Cursor" to Windows context menu
# This script requires administrator privileges
# Run this script with: PowerShell -ExecutionPolicy Bypass -File install-context-menu.ps1

# Check if running as Administrator
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "This script requires administrator privileges." -ForegroundColor Red
    Write-Host "Please run PowerShell as Administrator and try again." -ForegroundColor Yellow
    exit 1
}

Write-Host "Adding 'Open in Cursor' to context menu..." -ForegroundColor Green

# Detect Cursor installation path
$cursorPath = $null
$possiblePaths = @(
    "$env:LOCALAPPDATA\Programs\Cursor\Cursor.exe",
    "$env:ProgramFiles\Cursor\Cursor.exe",
    "${env:ProgramFiles(x86)}\Cursor\Cursor.exe"
)

foreach ($path in $possiblePaths) {
    if (Test-Path $path) {
        $cursorPath = $path
        break
    }
}

if (-not $cursorPath) {
    Write-Host "Cursor installation not found in standard locations." -ForegroundColor Yellow
    $cursorPath = Read-Host "Please enter the full path to Cursor.exe"
    
    if (-not (Test-Path $cursorPath)) {
        Write-Host "The specified path does not exist. Exiting." -ForegroundColor Red
        exit 1
    }
}

Write-Host "Found Cursor at: $cursorPath" -ForegroundColor Cyan

# Registry paths for context menu entries
$registryPaths = @(
    # Context menu for folders
    "HKEY_CLASSES_ROOT\Directory\shell\OpenInCursor",
    "HKEY_CLASSES_ROOT\Directory\shell\OpenInCursor\command",
    # Context menu for directory background
    "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenInCursor",
    "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenInCursor\command",
    # Context menu for files
    "HKEY_CLASSES_ROOT\*\shell\OpenInCursor",
    "HKEY_CLASSES_ROOT\*\shell\OpenInCursor\command"
)

# Add registry entries for folders
Write-Host "Adding context menu for folders..." -ForegroundColor Cyan
New-Item -Path "Registry::HKEY_CLASSES_ROOT\Directory\shell\OpenInCursor" -Force | Out-Null
Set-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\Directory\shell\OpenInCursor" -Name "(Default)" -Value "Open in Cursor"
Set-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\Directory\shell\OpenInCursor" -Name "Icon" -Value "`"$cursorPath`""

New-Item -Path "Registry::HKEY_CLASSES_ROOT\Directory\shell\OpenInCursor\command" -Force | Out-Null
Set-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\Directory\shell\OpenInCursor\command" -Name "(Default)" -Value "`"$cursorPath`" `"%V`""

# Add registry entries for directory background (right-click in empty space)
Write-Host "Adding context menu for directory background..." -ForegroundColor Cyan
New-Item -Path "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\OpenInCursor" -Force | Out-Null
Set-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\OpenInCursor" -Name "(Default)" -Value "Open in Cursor"
Set-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\OpenInCursor" -Name "Icon" -Value "`"$cursorPath`""

New-Item -Path "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\OpenInCursor\command" -Force | Out-Null
Set-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\OpenInCursor\command" -Name "(Default)" -Value "`"$cursorPath`" `"%V`""

# Add registry entries for files
Write-Host "Adding context menu for files..." -ForegroundColor Cyan
New-Item -Path "Registry::HKEY_CLASSES_ROOT\*\shell\OpenInCursor" -Force | Out-Null
Set-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\*\shell\OpenInCursor" -Name "(Default)" -Value "Open in Cursor"
Set-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\*\shell\OpenInCursor" -Name "Icon" -Value "`"$cursorPath`""

New-Item -Path "Registry::HKEY_CLASSES_ROOT\*\shell\OpenInCursor\command" -Force | Out-Null
Set-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\*\shell\OpenInCursor\command" -Name "(Default)" -Value "`"$cursorPath`" `"%1`""

Write-Host ""
Write-Host "Successfully added 'Open in Cursor' to context menu!" -ForegroundColor Green
Write-Host "You can now right-click on files and folders in Windows Explorer to open them in Cursor." -ForegroundColor Green
