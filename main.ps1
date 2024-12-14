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
    Write-Host "[1] Enable WSL"
    Write-Host "[2] Post-Restart Configuration"
    Write-Host "[3] Uninstall WSL"
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

# Function to Display the Package Management Menu
function Show-PackageMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "              Package Management:              " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Development Tools" -ForegroundColor Blue
    Write-Host "[2] System Monitoring Tools" -ForegroundColor Yellow
    Write-Host "[3] Communication and Gaming" -ForegroundColor Cyan
    Write-Host "[0] Go Back" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}

# Function to Display Development Tools Menu
function Show-DevelopmentToolsMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "              Development Tools:               " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Python"
    Write-Host "[2] Git"
    Write-Host "[3] Make"
    Write-Host "[4] VSCode"
    Write-Host "[0] Go Back" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}

# Function to Display System Monitoring Tools Menu
function Show-SystemMonitoringMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "         System Monitoring Tools:              " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] HWiNFO"
    Write-Host "[0] Go Back" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}

# Function to Display Communication and Gaming Menu
function Show-CommunicationGamingMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "        Communication and Gaming:              " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Discord"
    Write-Host "[2] Steam"
    Write-Host "[3] Valorant"
    Write-Host "[0] Go Back" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}

# Logic for Development Tools Menu
function Run-DevelopmentTools {
    do {
        Show-DevelopmentToolsMenu
        $selection = Read-Host "Please select an option"
        switch ($selection) {
            1 {
                Write-Host "Installing Python..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/installs/python.ps1" | iex
                Pause
            }
            2 {
                Write-Host "Installing Git..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/installs/git.ps1" | iex
                Pause
            }
            3 {
                Write-Host "Installing Make..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/make.ps1" | iex
                Pause
            }
            4 {
                Write-Host "Installing VSCode..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/vscode.ps1" | iex
                Pause
            }
            0 {
                Write-Host "Returning to Package Management Menu..." -ForegroundColor Yellow
                break
            }
            default {
                Write-Host "Invalid selection, please try again." -ForegroundColor Red
                Pause
            }
        }
    } while ($selection -ne 0)
}

# Logic for System Monitoring Tools Menu
function Run-SystemMonitoring {
    do {
        Show-SystemMonitoringMenu
        $selection = Read-Host "Please select an option"
        switch ($selection) {
            1 {
                Write-Host "Installing HWiNFO..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/hwinfo.ps1" | iex
                Pause
            }
            0 {
                Write-Host "Returning to Package Management Menu..." -ForegroundColor Yellow
                break
            }
            default {
                Write-Host "Invalid selection, please try again." -ForegroundColor Red
                Pause
            }
        }
    } while ($selection -ne 0)
}

# Logic for Communication and Gaming Menu
function Run-CommunicationGaming {
    do {
        Show-CommunicationGamingMenu
        $selection = Read-Host "Please select an option"
        switch ($selection) {
            1 {
                Write-Host "Installing Discord..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/discord.ps1" | iex
                Pause
            }
            2 {
                Write-Host "Installing Steam..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/steam.ps1" | iex
                Pause
            }
            3 {
                Write-Host "Installing Valorant..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/valorant.ps1" | iex
                Pause
            }
            0 {
                Write-Host "Returning to Package Management Menu..." -ForegroundColor Yellow
                break
            }
            default {
                Write-Host "Invalid selection, please try again." -ForegroundColor Red
                Pause
            }
        }
    } while ($selection -ne 0)
}

# Logic for Package Management Menu
function Run-PackageManagement {
    do {
        Show-PackageMenu
        $selection = Read-Host "Please select an option"
        switch ($selection) {
            1 {
                Run-DevelopmentTools
            }
            2 {
                Run-SystemMonitoring
            }
            3 {
                Run-CommunicationGaming
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
    } while ($selection -ne 0)
}

# Logic for Windows Configurations
function Run-WindowsConfigurations {
    Write-Host "Running Windows Configurations..." -ForegroundColor Cyan
    irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/microsoft/Windows.ps1" | iex
}

# Main Menu Logic
do {
    Show-Menu
    $selection = Read-Host "Please select an option"
    switch ($selection) {
        1 {
            Run-PackageManagement
        }
        2 {
            Run-WSLConfiguration
        }
        3 {
            Run-WindowsConfigurations
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
