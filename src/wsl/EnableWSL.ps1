# Enable WSL and Virtual Machine Platform features
Write-Host "Enabling WSL and Virtual Machine Platform features..." -ForegroundColor Green
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

# Set a marker file to indicate the first part has run
$markerPath = "$env:USERPROFILE\.wsl-setup-marker"
Set-Content -Path $markerPath -Value "WSL Features Enabled"

# Prompt before restarting
Write-Host ""
Write-Host "WSL features have been enabled. A restart is required to apply changes." -ForegroundColor Yellow
$response = Read-Host "Do you want to restart now? (yes/no)"
if ($response -eq "yes") {
    Write-Host "Restarting in 10 seconds... Save your work!" -ForegroundColor Red
    Start-Sleep -Seconds 10
    Restart-Computer -Force
} else {
    Write-Host "Please restart your computer manually before running the Post-Restart Configuration." -ForegroundColor Yellow
}
