# Function to prompt for an action
function Prompt-Action {
    param (
        [string]$ActionDescription
    )

    $response = Read-Host ("Do you want to `"$ActionDescription`"? (yes/no)")
    return $response -eq "yes"
}

# Prompt for WSL uninstallation
if (Prompt-Action -ActionDescription "uninstall WSL and related features") {
    # Remove all installed WSL distributions
    Write-Host "Unregistering all installed WSL distributions..." -ForegroundColor Yellow
    $wslDistributions = wsl --list --quiet
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
    $kernelPackage = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name LIKE 'Windows Subsystem for Linux Update%'"
    if ($kernelPackage) {
        $kernelPackage.Uninstall()
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

    # Remove any WSL installation cache files
    $wslCachePath = "C:\Program Files\WindowsApps"
    $wslCacheFiles = Get-ChildItem -Path $wslCachePath -Recurse -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -like "wsl.exe" -or $_.FullName -like "*WindowsSubsystemForLinux*" }
    foreach ($file in $wslCacheFiles) {
        Remove-Item -Path $file.FullName -Force -Recurse -ErrorAction SilentlyContinue
    }


    # Final step: Restart the computer
    Write-Host "Uninstallation complete. Please restart your computer to finalize changes." -ForegroundColor Green
} else {
    Write-Host "WSL uninstallation skipped." -ForegroundColor Cyan
}
