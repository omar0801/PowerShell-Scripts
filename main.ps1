# Main GUI Menu Script
function Show-Menu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "               System Configuration Menu:      " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Package Management" -ForegroundColor Blue
    Write-Host "[2] WSL (Enable/Configure/Uninstall)" -ForegroundColor Yellow
    Write-Host "[3] Windows Configurations" -ForegroundColor Cyan
    Write-Host "[0] Exit" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}

# Function to Display the WSL Menu
function Show-WSLMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "               WSL Configuration Menu:        " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Enable WSL" -ForegroundColor Blue
    Write-Host "[2] Post-Restart Configuration" -ForegroundColor Yellow
    Write-Host "[3] Uninstall WSL" -ForegroundColor Cyan
    Write-Host "[0] Back to Main Menu" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}

# Functions for WSL Options
function Enable-WSL {
    Write-Host "Running Enable WSL Script directly from GitHub..." -ForegroundColor Cyan
    irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/wsl/EnableWSL.ps1" | iex
}

function Post-RestartWSL {
    Write-Host "Running Post-Restart Configuration Script directly from GitHub..." -ForegroundColor Cyan
    irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/wsl/PostRestartWSL.ps1" | iex
}

function Uninstall-WSL {
    Write-Host "Running Uninstall WSL Script directly from GitHub..." -ForegroundColor Cyan
    irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/wsl/UninstallWSL.ps1" | iex
}

# WSL Menu Logic
function Run-WSLConfiguration {
    do {
        Show-WSLMenu
        $wslSelection = Read-Host "Please select an option"
        
        switch ($wslSelection) {
            1 {
                Enable-WSL
                Pause
            }
            2 {
                Post-RestartWSL
                Pause
            }
            3 {
                Uninstall-WSL
                Pause
            }
            0 {
                Write-Host "Returning to Main Menu..." -ForegroundColor Yellow
                break
            }
            default {
                Write-Host "Invalid selection, please try again." -ForegroundColor Red
                Pause
            }
        }
    } while ($wslSelection -ne 0)
}

# Placeholder Functions for Other Menus
function Run-PackageManagement {
    Write-Host "You selected 'Package Management'." -ForegroundColor Cyan
    # Add logic to fetch and execute scripts for package management
}

function Run-WindowsConfigurations {
    Write-Host "You selected 'Windows Configurations'." -ForegroundColor Cyan
    # Add logic to fetch and execute scripts for Windows configurations
}

# Main Menu Logic
do {
    Show-Menu
    $selection = Read-Host "Please select an option"
    
    switch ($selection) {
        1 {
            Run-PackageManagement
            Pause
        }
        2 {
            Run-WSLConfiguration
        }
        3 {
            Run-WindowsConfigurations
            Pause
        }
        0 {
            Write-Host "Exiting... Goodbye!" -ForegroundColor Red
            break
        }
        default {
            Write-Host "Invalid selection, please try again." -ForegroundColor Red
            Pause
        }
    }
} while ($selection -ne 0)
