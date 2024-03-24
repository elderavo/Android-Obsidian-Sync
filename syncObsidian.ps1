# Define the paths
$localFolder = "C:\Users\Alex's PC\OneDrive\Documents\Obsidian Vault"
$phoneFolderPath = "/storage/self/primary/Documents/Obsidian Vault" 
$adbPath = "C:\Android\platform-tools"

# Change directory to where adb is located
Set-Location -Path $adbPath

# Check if the device is connected and adb is responding
$adbDevices = .\adb.exe devices
if ($adbDevices -like "*device") {
    Write-Host "Device is connected. Starting sync..."

    # Sync files from phone to local folder (adb pull)
    .\adb.exe pull $phoneFolderPath "C:\Users\Alex's PC\OneDrive\Documents"

    # Sync files from local folder to phone (adb push)
    Get-ChildItem -Path $localFolder | ForEach-Object {
        $item = $_
        .\adb.exe push $item.FullName $phoneFolderPath
    }
    Write-Host "Sync complete."
} else {
    Write-Host "No device connected or adb is not responding. Please check your connection and try again."
}

# Return to the previous directory
Set-Location -Path $PWD
