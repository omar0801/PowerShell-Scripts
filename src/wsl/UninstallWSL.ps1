# Remove all installed WSL distributions
Write-Host "Unregistering all installed WSL distributions..." -ForegroundColor Yellow
$wslDistributions = (wsl --list --quiet) | ForEach-Object { $_.Trim("`0") } | Where-Object { $_ -ne "" }
foreach ($dist in $wslDistributions) {
    Write-Host "Unregistering $dist..." -ForegroundColor Cyan
    wsl --unregister $dist
}

# Disable WSL and Virtual Machine Platform features
Write-Host "Disabling WSL and Virtual Machine Platform features..." -ForegroundColor Yellow
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
Disable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

# Remove the WSL Linux kernel update package
Write-Host "Removing WSL Linux kernel update package..." -ForegroundColor Yellow
$kernelPackage = Get-Package -Name "Windows Subsystem for Linux Update*" -ErrorAction SilentlyContinue
if ($kernelPackage) {
    $kernelPackage | Uninstall-Package -Force
    Write-Host "WSL Linux kernel update package removed." -ForegroundColor Green
} else {
    Write-Host "No WSL Linux kernel update package found." -ForegroundColor Cyan
}

# Remove residual WSL files and registry entries
Write-Host "Cleaning up residual WSL files and registry entries..." -ForegroundColor Yellow

# Remove .wslconfig in user profile
$wslConfigPath = "$env:USERPROFILE\.wslconfig"
if (Test-Path $wslConfigPath) {
    Remove-Item -Path $wslConfigPath -Force
    Write-Host "Removed .wslconfig file." -ForegroundColor Green
} else {
    Write-Host ".wslconfig file not found." -ForegroundColor Cyan
}

# Remove registry keys related to WSL
$wslRegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LxssManager"
if (Test-Path $wslRegistryPath) {
    Remove-Item -Path $wslRegistryPath -Recurse -Force
    Write-Host "Removed WSL registry entries." -ForegroundColor Green
} else {
    Write-Host "No WSL registry entries found." -ForegroundColor Cyan
}

# Remove WSL app packages properly
Write-Host "Removing WSL app packages..." -ForegroundColor Yellow
$wslPackages = Get-AppxPackage -Name "*WindowsSubsystemForLinux*" -ErrorAction SilentlyContinue
if ($wslPackages) {
    $wslPackages | Remove-AppxPackage
    Write-Host "WSL app packages removed." -ForegroundColor Green
} else {
    Write-Host "No WSL app packages found." -ForegroundColor Cyan
}

# Clean up the setup marker file if it exists
$markerPath = "$env:USERPROFILE\.wsl-setup-marker"
if (Test-Path $markerPath) {
    Remove-Item -Path $markerPath -Force
}

# Final step
Write-Host "Uninstallation complete. Please restart your computer to finalize changes." -ForegroundColor Green
