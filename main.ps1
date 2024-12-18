# Main GUI Menu Script
function Show-Menu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "          System Configuration Menu:          " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Package Management" -ForegroundColor Blue
    Write-Host "[2] WSL (Enable/Configure/Uninstall)" -ForegroundColor Yellow
    Write-Host "[3] Windows Configurations" -ForegroundColor Cyan
    Write-Host "[4] Troubleshooting" -ForegroundColor Magenta
    Write-Host "[0] Exit" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}

# ==========================================================
# SECTION: WSL Menu
# ==========================================================
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

# ==========================================================
# SECTION: Package Management Menu
# ==========================================================
# Function to Display the Package Management Menu
function Show-PackageMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "              Package Management:              " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Development Tools" -ForegroundColor Blue
    Write-Host "[2] System Monitoring Tools" -ForegroundColor Yellow
    Write-Host "[3] Benchmarking" -ForegroundColor Cyan
    Write-Host "[4] Communication and Gaming" -ForegroundColor Magenta
    Write-Host "[0] Go Back" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}

# ==========================================================
# SECTION: Package Management Logic
# ==========================================================
function Run-PackageManagement {
    do {
        Show-PackageMenu
        $packageSelection = Read-Host "Please select an option"
        switch ($packageSelection) {
            1 {
                Run-DevelopmentTools
            }
            2 {
                Run-SystemMonitoring
            }
            3 {
                Run-Benchmarking
            }
            4 {
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
    } while ($packageSelection -ne 0)
}

# ==========================================================
# SECTION: Development Tools Menu
# ==========================================================
# Function to Display Development Tools Menu
function Show-DevelopmentToolsMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "              Development Tools:               " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Python"
    Write-Host "[2] Git"
    Write-Host "[3] VSCode"
    Write-Host "[4] Make"
    Write-Host "[5] Tree"
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
                Write-Host "Installing Vscode..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/vscode.ps1" | iex
                Pause
            }
            4 {
                Write-Host "Installing Make..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/make.ps1" | iex
                Pause
            }
            5 {
                Write-Host "Installing Tree..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/tree.ps1" | iex
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

# ==========================================================
# SECTION: System Monitoring Tools Menu
# ==========================================================
# Function to Display System Monitoring Tools Menu
function Show-SystemMonitoringMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "         System Monitoring Tools:              " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] HWiNFO"
    Write-Host "[2] CPU-Z"
    Write-Host "[3] GPU-Z"
    Write-Host "[4] Core Temp"
    Write-Host "[5] CrystalDiskInfo"
    Write-Host "[0] Go Back" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
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
            2 {
                Write-Host "Installing CPU-Z..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/cpu-z.ps1" | iex
                Pause
            }
            3 {
                Write-Host "Installing GPU-Z..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/gpu-z.ps1" | iex
                Pause
            }
            4 {
                Write-Host "Installing Core Temp..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/coretemp.ps1" | iex
                Pause
            }
            5 {
                Write-Host "Installing CrystalDiskInfo Temp..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/crystaldiskinfo.ps1" | iex
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

# ==========================================================
# SECTION: Communication and Gaming Menu
# ==========================================================
# Function to Display Communication and Gaming Menu
function Show-CommunicationGamingMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "        Communication and Gaming:              " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Discord"
    Write-Host "[2] Steam"
    Write-Host "[3] Valorant"
    Write-Host "[4] League of Legends"
    Write-Host "[0] Go Back" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
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
            4 {
                Write-Host "Installing League of Legends..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/leagueoflegends.ps1" | iex
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
# ==========================================================
# SECTION: Benchmarking Menu
# ==========================================================
# Function to Display Benchmarking Menu
function Show-Benchmarking {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "                Benchmarking:                 " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Cinebench"
    Write-Host "[2] Occt"
    Write-Host "[3] Heaven Benchmark"
    Write-Host "[4] CrystalDiskMark"
    Write-Host "[0] Go Back" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}


# Logic for Communication and Gaming Menu
function Run-Benchmarking {
    do {
        Show-Benchmarking
        $selection = Read-Host "Please select an option"
        switch ($selection) {
            1 {
                Write-Host "Installing Cinebench..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/cinebench.ps1" | iex
                Pause
            }
            2 {
                Write-Host "Installing Occt..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/occt.ps1" | iex
                Pause
            }
            3 {
                Write-Host "Installing Heaven Benchmark..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/heavenbenchmark.ps1" | iex
                Pause
            }
            4 {
                Write-Host "Installing Heaven CrystalDiskMark..."
                irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/choco-installs/crystaldiskmark.ps1" | iex
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


# ==========================================================
# SECTION: Troubleshooting Menu
# ==========================================================
function Show-TroubleshootingMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "              Troubleshooting Menu:            " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Reset Network Configuration" -ForegroundColor Blue
    Write-Host "[2] Check Disk Health" -ForegroundColor Yellow
    Write-Host "[3] Repair System Files (SFC Scan)" -ForegroundColor Cyan
    Write-Host "[4] Clean Temporary Files" -ForegroundColor Magenta
    Write-Host "[5] Uninstall Chocolatey (" -ForegroundColor Green -NoNewline
    Write-Host "Warning: Removes all Chocolatey-installed apps" -ForegroundColor Red -NoNewline
    Write-Host ")" -ForegroundColor Green
    Write-Host "[0] Go Back" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}


# Functions for Troubleshooting Options
function Reset-Network {
    Write-Host "Resetting Network Configuration..." -ForegroundColor Cyan
    netsh winsock reset
    netsh int ip reset
    Write-Host "Network Configuration Reset Complete. Please restart your system if necessary." -ForegroundColor Green
    Pause
}

function Check-DiskHealth {
    Write-Host "Running Disk Health Check..." -ForegroundColor Cyan
    chkdsk C: /f /r
    Write-Host "Disk Health Check initiated. It may require a system reboot to complete." -ForegroundColor Green
    Pause
}

function Repair-SystemFiles {
    Write-Host "Starting System File Checker (SFC) Scan..." -ForegroundColor Cyan
    sfc /scannow
    Write-Host "System File Checker Scan Complete." -ForegroundColor Green
    Pause
}

function Clean-TempFiles {
    Write-Host "Cleaning Temporary Files..." -ForegroundColor Cyan
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Temporary Files Cleaned Successfully." -ForegroundColor Green
    Pause
}
function Uninstall-Chocolatey {
    Write-Host "WARNING: This will uninstall Chocolatey and all apps installed through it." -ForegroundColor Red
    $confirmation = Read-Host "Are you sure you want to proceed? (yes/no)"
    if ($confirmation -eq "yes") {
        Write-Host "Uninstalling Chocolatey..." -ForegroundColor Cyan
        irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/troubleshooting/UninstallChoco.ps1" | iex
        Write-Host "Chocolatey has been uninstalled." -ForegroundColor Green
    } else {
        Write-Host "Operation canceled." -ForegroundColor Yellow
    }
    Pause
}
# Troubleshooting Menu Logic
function Run-Troubleshooting {
    do {
        Show-TroubleshootingMenu
        $troubleSelection = Read-Host "Please select an option"
        switch ($troubleSelection) {
            1 {
                Reset-Network
            }
            2 {
                Check-DiskHealth
            }
            3 {
                Repair-SystemFiles
            }
            4 {
                Clean-TempFiles
            }
            5 {
                Uninstall-Chocolatey
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
    } while ($troubleSelection -ne 0)
}


# ==========================================================
# SECTION: Windows Configurations
# ==========================================================
function Run-WindowsConfigurations {
    Write-Host "Running Windows Configurations..." -ForegroundColor Cyan
    irm "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main/src/microsoft/Windows.ps1" | iex
}

# ==========================================================
# SECTION: Main Menu Logic
# ==========================================================
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
        4 {
            Run-Troubleshooting
        }
        0 {
            Write-Host "Exiting... Goodbye and shush!" -ForegroundColor Red
            break
        }
        default {
            Write-Host "Invalid selection, please try again." -ForegroundColor Red
            Pause
        }
    }
} while ($selection -ne 0)