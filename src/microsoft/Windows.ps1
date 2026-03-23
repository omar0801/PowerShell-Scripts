# Windows Configuration Script

function Show-WindowsConfigMenu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "          Windows Configurations:             " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Enable Dark Mode"
    Write-Host "[2] Set High Performance Power Plan"
    Write-Host "[3] Show File Extensions in Explorer"
    Write-Host "[4] Enable Developer Mode"
    Write-Host "[0] Go Back" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}

function Enable-DarkMode {
    Write-Host "Enabling Dark Mode..." -ForegroundColor Cyan
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Type DWord -Force
    Write-Host "Dark Mode enabled." -ForegroundColor Green
    Pause
}

function Set-HighPerformancePlan {
    Write-Host "Setting High Performance power plan..." -ForegroundColor Cyan
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    if ($?) {
        Write-Host "High Performance power plan activated." -ForegroundColor Green
    } else {
        Write-Host "Failed to set power plan. It may not be available on this system." -ForegroundColor Red
    }
    Pause
}

function Show-FileExtensions {
    Write-Host "Enabling file extensions in Explorer..." -ForegroundColor Cyan
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type DWord -Force
    Write-Host "File extensions are now visible in Explorer." -ForegroundColor Green
    Pause
}

function Enable-DeveloperMode {
    Write-Host "Enabling Developer Mode..." -ForegroundColor Cyan
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Value 1 -Type DWord -Force
    Write-Host "Developer Mode enabled." -ForegroundColor Green
    Pause
}

do {
    Show-WindowsConfigMenu
    $configSelection = Read-Host "Please select an option"
    switch ($configSelection) {
        1 { Enable-DarkMode }
        2 { Set-HighPerformancePlan }
        3 { Show-FileExtensions }
        4 { Enable-DeveloperMode }
        0 {
            Write-Host "Returning to Main Menu..." -ForegroundColor Yellow
            break
        }
        default {
            Write-Host "Invalid selection, please try again." -ForegroundColor Red
            Pause
        }
    }
} while ($configSelection -ne 0)
