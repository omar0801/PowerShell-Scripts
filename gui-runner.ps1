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
    Write-Host "[1] Install Packages"
    Write-Host "[2] Remove Chocolatey Packages"
    Write-Host "[0] Go Back"
    Write-Host "==============================================" -ForegroundColor Green
}

function Show-WSLMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "                 WSL Options:                 " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Enable WSL"
    Write-Host "[2] Post-Restart Tasks for WSL"
    Write-Host "[3] Uninstall WSL"
    Write-Host "[0] Go Back"
    Write-Host "==============================================" -ForegroundColor Green
}

function Execute-Script ($ScriptName) {
    $RepoBaseURL = "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main"
    $ScriptURL = "$RepoBaseURL/$ScriptName"
    try {
        Write-Host "Executing $ScriptName..." -ForegroundColor Yellow
        Invoke-RestMethod -Uri $ScriptURL -OutFile "$env:TEMP\$ScriptName"
        PowerShell -ExecutionPolicy Bypass -File "$env:TEMP\$ScriptName"
    } catch {
        Write-Host "Error executing script `"$ScriptName`": $($_)" -ForegroundColor Red
    }
}

# Main Menu Loop
while ($true) {
    Show-Menu
    $choice = Read-Host "Choose a menu option using your keyboard [1,2,3,0]"

    switch ($choice) {
        1 {
            # Package Management Submenu
            $inPackageMenu = $true
            while ($inPackageMenu) {
                Show-PackageMenu
                $packageChoice = Read-Host "Choose a Package Management option using your keyboard [1,2,0]"

                switch ($packageChoice) {
                    1 { Execute-Script "installs.ps1" }
                    2 { Execute-Script "choco_remove.ps1" }
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
