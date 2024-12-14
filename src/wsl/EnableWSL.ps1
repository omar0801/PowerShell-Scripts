# Function to prompt for enabling features
function Prompt-EnableFeatures {
    param (
        [string]$FeatureDescription
    )

    $response = Read-Host ("Do you want to enable `"$FeatureDescription`"? (yes/no)")
    return $response -eq "yes"
}

# Prompt for enabling WSL and Virtual Machine Platform features
if (Prompt-EnableFeatures -FeatureDescription "WSL and Virtual Machine Platform features") {
    Write-Host "Enabling WSL and Virtual Machine Platform features..." -ForegroundColor Green
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

    # Set a marker file to indicate the first part has run
    $markerPath = "$env:Temp\WSLInstalled.txt"
    Set-Content -Path $markerPath -Value "WSL Features Enabled"

    # Restart the system
    Write-Host "Restarting the system to apply changes..." -ForegroundColor Yellow
    Restart-Computer -Force
} else {
    Write-Host "WSL and Virtual Machine Platform feature enablement skipped."
}
