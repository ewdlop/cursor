# Windows Context Menu Integration for Cursor

This directory contains scripts and registry files to add "Open in Cursor" to the Windows Explorer context menu.

## Features

After installation, you will be able to:
- Right-click on any file and select "Open in Cursor"
- Right-click on any folder and select "Open in Cursor"
- Right-click on empty space in a folder and select "Open in Cursor" to open that directory

## Installation Methods

### Method 1: PowerShell Script (Recommended)

The PowerShell script automatically detects your Cursor installation and configures the registry.

1. **Run PowerShell as Administrator**
   - Right-click on the Windows Start menu
   - Select "Windows PowerShell (Admin)" or "Terminal (Admin)"

2. **Navigate to this directory**
   ```powershell
   cd path\to\cursor\windows
   ```

3. **Run the installation script**
   ```powershell
   PowerShell -ExecutionPolicy Bypass -File install-context-menu.ps1
   ```

The script will:
- Automatically detect your Cursor installation location
- If not found, prompt you to enter the path
- Add context menu entries for files, folders, and directory backgrounds

### Method 2: Registry File

If you prefer to manually install using a registry file:

1. **Edit the registry file**
   - Open `install-context-menu.reg` in a text editor
   - Replace `C:\\Users\\YourUsername\\AppData\\Local\\Programs\\Cursor\\Cursor.exe` with your actual Cursor installation path
   - Common locations:
     - `C:\Users\YourUsername\AppData\Local\Programs\Cursor\Cursor.exe`
     - `C:\Program Files\Cursor\Cursor.exe`
     - `C:\Program Files (x86)\Cursor\Cursor.exe`

2. **Import the registry file**
   - Double-click `install-context-menu.reg`
   - Click "Yes" when prompted to confirm
   - Click "OK" when the import is successful

## Uninstallation

### Using PowerShell Script

1. **Run PowerShell as Administrator**
2. **Navigate to this directory**
   ```powershell
   cd path\to\cursor\windows
   ```
3. **Run the uninstallation script**
   ```powershell
   PowerShell -ExecutionPolicy Bypass -File uninstall-context-menu.ps1
   ```

### Using Registry File

1. Double-click `uninstall-context-menu.reg`
2. Click "Yes" when prompted to confirm
3. Click "OK" when the removal is successful

## Finding Your Cursor Installation Path

If you need to find where Cursor is installed on your system:

1. **Using PowerShell:**
   ```powershell
   Get-ChildItem -Path "$env:LOCALAPPDATA\Programs" -Filter "Cursor.exe" -Recurse -ErrorAction SilentlyContinue
   Get-ChildItem -Path "$env:ProgramFiles" -Filter "Cursor.exe" -Recurse -ErrorAction SilentlyContinue
   ```

2. **Using Start Menu:**
   - Right-click on Cursor in the Start Menu
   - Select "Open file location"
   - If it's a shortcut, right-click the shortcut and select "Open file location" again
   - Copy the full path to `Cursor.exe`

## Troubleshooting

### "This script requires administrator privileges"
- You must run PowerShell as Administrator to modify registry entries
- Right-click on PowerShell and select "Run as Administrator"

### Context menu entries not appearing
- Try restarting Windows Explorer:
  - Press `Ctrl + Shift + Esc` to open Task Manager
  - Find "Windows Explorer" in the processes list
  - Right-click and select "Restart"
- Or restart your computer

### Wrong Cursor path
- Uninstall using the uninstall script/registry file
- Reinstall with the correct path

## Technical Details

The installation modifies the following registry keys:

- `HKEY_CLASSES_ROOT\Directory\shell\OpenInCursor` - For folder context menu
- `HKEY_CLASSES_ROOT\Directory\Background\shell\OpenInCursor` - For directory background
- `HKEY_CLASSES_ROOT\*\shell\OpenInCursor` - For file context menu

Each key includes:
- Display name: "Open in Cursor"
- Icon: Path to Cursor.exe
- Command: Launches Cursor with the selected file/folder path

## Security Note

Modifying the registry requires administrator privileges and can affect system behavior. Always:
- Run scripts from trusted sources
- Review registry file contents before importing
- Keep backups of your registry (Windows creates automatic backups)

## Support

For issues or feature requests, please visit:
- [Cursor Forum](https://forum.cursor.com/)
- [GitHub Issues](https://github.com/getcursor/cursor/issues)
