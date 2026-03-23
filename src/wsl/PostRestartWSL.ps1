# Check if the marker file exists
$markerPath = "$env:USERPROFILE\.wsl-setup-marker"
if (-Not (Test-Path $markerPath)) {
    Write-Host "WSL features have not been enabled yet. Please run EnableWSL.ps1 first." -ForegroundColor Red
    return
}

# Update WSL to the latest version
Write-Host "Updating WSL to the latest version..." -ForegroundColor Green
wsl --update

# Set WSL 2 as the default version
Write-Host "Setting WSL 2 as the default version..." -ForegroundColor Green
wsl --set-default-version 2

# Let the user choose a distribution
Write-Host ""
Write-Host "Available distributions:" -ForegroundColor Cyan
Write-Host "[1] Ubuntu (default)"
Write-Host "[2] Debian"
Write-Host "[3] kali-linux"
Write-Host "[4] openSUSE-Leap-15.6"
Write-Host "[5] Ubuntu-24.04"
$distroChoice = Read-Host "Select a distribution (1-5, default: 1)"

$distro = switch ($distroChoice) {
    2 { "Debian" }
    3 { "kali-linux" }
    4 { "openSUSE-Leap-15.6" }
    5 { "Ubuntu-24.04" }
    default { "Ubuntu" }
}

Write-Host "Installing $distro distribution..." -ForegroundColor Green
wsl --install -d $distro

# Clean up the marker file
Remove-Item -Path $markerPath -Force

Write-Host "Installation complete. Please restart your machine if prompted." -ForegroundColor Green
