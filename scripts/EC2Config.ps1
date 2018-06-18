$EC2SettingsFile="C:\\ProgramData\\Amazon\EC2-Windows\\Launch\Config\\LaunchConfig.json"

$EC2Settings = (get-content $EC2SettingsFile) | ConvertFrom-Json
$EC2Settings.adminPasswordType = "Random"
$EC2Settings.setWallpaper = $true
$EC2Settings.setComputerName = $true
$EC2Settings | ConvertTo-Json  | set-content $EC2SettingsFile

& "C:\ProgramData\Amazon\EC2-Windows\Launch\Scripts\InitializeInstance.ps1" -Schedule
& "C:\ProgramData\Amazon\EC2-Windows\Launch\Scripts\SendEventLogs.ps1" -Schedule
& "C:\ProgramData\Amazon\EC2-Windows\Launch\Scripts\SendWindowsIsReady.ps1" -Schedule