function Show-Menu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "               System Configuration Menu:      " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Package Management" -ForegroundColor Blue
    Write-Host "[2] WSL (Enable/Configure/Uninstall)"
    Write-Host "[3] Windows Configurations"
    Write-Host "[0] Exit" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}

function Show-PackageMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "              Package Management:              " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Install Python"
    Write-Host "[2] Install Git"
    Write-Host "[3] Install Chocolatey"
    Write-Host "[4] Install make"
    Write-Host "[5] Install VSCode"
    Write-Host "[6] Install HWiNFO"
    Write-Host "[7] Install Discord"
    Write-Host "[8] Install Steam"
    Write-Host "[9] Install Valorant"
    Write-Host "[10] Install Windscribe"
    Write-Host "[0] Go Back"
    Write-Host "==============================================" -ForegroundColor Green
}

# Executes the installs.ps1 script with the specified package name
function Install-Package {
    param (
        [string]$PackageName
    )

    $ScriptPath = "$env:TEMP\\installs.ps1"
    $RepoBaseURL = "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main"
    $ScriptURL = "$RepoBaseURL/installs.ps1"

    try {
        # Download the script if it doesn't exist locally or update it
        if (-not (Test-Path $ScriptPath)) {
            Write-Host "Downloading installs.ps1..." -ForegroundColor Yellow
            Invoke-WebRequest -Uri $ScriptURL -OutFile $ScriptPath -ErrorAction Stop
        }

        # Ensure the script is executable
        Write-Host "Running installs.ps1 for $PackageName..." -ForegroundColor Cyan
        & PowerShell -ExecutionPolicy Bypass -File $ScriptPath -PackageName $PackageName
    } catch {
        Write-Host "Error executing installs.ps1: $($_.Exception.Message)" -ForegroundColor Red
    }
}

function Execute-Script ($ScriptName) {
    $RepoBaseURL = "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main"
    $ScriptURL = "$RepoBaseURL/$ScriptName"

    try {
        Write-Host "Downloading and executing $ScriptName..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri $ScriptURL -OutFile "$env:TEMP\\$ScriptName" -ErrorAction Stop
        & PowerShell -ExecutionPolicy Bypass -File "$env:TEMP\\$ScriptName"
    } catch {
        Write-Host "Error executing script `"$ScriptName`": $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Main Menu Logic
while ($true) {
    Show-Menu
    $choice = Read-Host "Choose a menu option using your keyboard [1,2,3,0]"

    switch ($choice) {
        1 {
            # Package Management Submenu
            $inPackageMenu = $true
            while ($inPackageMenu) {
                Show-PackageMenu
                $packageChoice = Read-Host "Choose a package to install using your keyboard [1-10,0]"

                switch ($packageChoice) {
                    1 { Install-Package "Python" }
                    2 { Install-Package "Git" }
                    3 { Install-Package "Chocolatey" }
                    4 { Install-Package "make" }
                    5 { Install-Package "VSCode" }
                    6 { Install-Package "HWiNFO" }
                    7 { Install-Package "Discord" }
                    8 { Install-Package "Steam" }
                    9 { Install-Package "Valorant" }
                    10 { Install-Package "Windscribe" }
                    0 { $inPackageMenu = $false }  # Exit Package Management submenu
                    default { Write-Host "Invalid option. Please try again." -ForegroundColor Yellow }
                }
            }
        }
        2 {
            # WSL Submenu
            $inWSLMenu = $true
            while ($inWSLMenu) {
                Show-WSLMenu
                $wslChoice = Read-Host "Choose a WSL option using your keyboard [1,2,3,0]"

                switch ($wslChoice) {
                    1 { Execute-Script "EnableWSL.ps1" }
                    2 { Execute-Script "PostRestartWSL.ps1" }
                    3 { Execute-Script "UninstallWSL.ps1" }
                    0 { $inWSLMenu = $false }  # Exit WSL submenu
                    default { Write-Host "Invalid option. Please try again." -ForegroundColor Yellow }
                }
            }
        }
        3 {
            Write-Host "Executing Windows Configurations..." -ForegroundColor Yellow
            Invoke-Expression (Invoke-RestMethod -Uri "https://get.activated.win")
        }
        0 { 
            Write-Host "Exiting the program. Goodbye!" -ForegroundColor Red
            Start-Sleep -Seconds 1
            Remove-Job * -Force -ErrorAction SilentlyContinue
            exit
        }
        default { Write-Host "Invalid option. Please try again." -ForegroundColor Yellow }
    }
    Start-Sleep -Seconds 2
}
