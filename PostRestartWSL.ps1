# Function to prompt for updating WSL
function Prompt-UpdateWSL {
    param (
        [string]$UpdateDescription
    )

    $response = Read-Host ("Do you want to `"$UpdateDescription`"? (yes/no)")
    return $response -eq "yes"
}

# Check if the marker file exists
$markerPath = "$env:Temp\WSLInstalled.txt"
if (-Not (Test-Path $markerPath)) {
    Write-Host "WSL features have not been enabled yet. Please run EnableWSL.ps1 first." -ForegroundColor Red
    Exit
}

# Prompt for updating WSL and related tasks
if (Prompt-UpdateWSL -UpdateDescription "update WSL to the latest version") {
    # Update WSL to the latest version
    Write-Host "Updating WSL to the latest version..." -ForegroundColor Green
    wsl --update

    # Set WSL 2 as the default version
    Write-Host "Setting WSL 2 as the default version..." -ForegroundColor Green
    wsl --set-default-version 2

    # Install Ubuntu as the default Linux distribution
    Write-Host "Installing Ubuntu distribution..." -ForegroundColor Green
    wsl --install -d Ubuntu

    # Clean up the marker file
    Remove-Item -Path $markerPath -Force

    Write-Host "Installation complete. Please restart your machine if prompted." -ForegroundColor Green
} else {
    Write-Host "WSL update and related tasks skipped."
}
