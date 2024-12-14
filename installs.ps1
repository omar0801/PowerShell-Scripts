param (
    [string]$PackageName
)

# Function to install Chocolatey if not already installed
function Ensure-Chocolatey {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is not installed. Installing Chocolatey..." -ForegroundColor Yellow
        Set-ExecutionPolicy Bypass -Scope Process -Force
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
            Write-Error "Failed to install Chocolatey. Exiting."
            exit 1
        }
        Write-Host "Chocolatey installed successfully." -ForegroundColor Green
    }
}

# Generic function to install Chocolatey packages
function Install-ChocoPackage {
    param (
        [string]$AppName,
        [string]$ChocoPackageName
    )

    Ensure-Chocolatey

    Write-Host "Installing $AppName via Chocolatey..." -ForegroundColor Cyan
    choco install $ChocoPackageName -y

    Write-Host "Verifying $AppName installation..."
    if (Get-Command $ChocoPackageName -ErrorAction SilentlyContinue) {
        Write-Host "$AppName installed successfully." -ForegroundColor Green
    } else {
        Write-Host "$AppName installation failed." -ForegroundColor Red
    }
}

# Main logic for installing specific software
switch ($PackageName) {
    "Python" {
        # Example Python installation logic
        Write-Host "Installing Python..." -ForegroundColor Cyan
        # Add Python installation code here
    }
    "Git" {
        # Example Git installation logic
        Write-Host "Installing Git..." -ForegroundColor Cyan
        # Add Git installation code here
    }
    "make" { Install-ChocoPackage -AppName "make" -ChocoPackageName "make" }
    "VSCode" { Install-ChocoPackage -AppName "VSCode" -ChocoPackageName "vscode.install" }
    "HWiNFO" { Install-ChocoPackage -AppName "HWiNFO" -ChocoPackageName "hwinfo.install" }
    "Discord" { Install-ChocoPackage -AppName "Discord" -ChocoPackageName "discord.install" }
    "Steam" { Install-ChocoPackage -AppName "Steam" -ChocoPackageName "steam" }
    "Valorant" { Install-ChocoPackage -AppName "Valorant" -ChocoPackageName "valorant" }
    "Windscribe" { Install-ChocoPackage -AppName "Windscribe" -ChocoPackageName "windscribe" }
    default {
        Write-Host "Invalid Package Name: $PackageName" -ForegroundColor Red
        exit 1
    }
}
