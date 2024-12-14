function Show-Menu {
    cls
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "               Activation Methods:             " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "[1] Remove Chocolatey Packages"
    Write-Host "[2] Uninstall WSL"
    Write-Host "[3] Windows Configurations"
    Write-Host "[4] Enable WSL"
    Write-Host "[5] Install Packages"
    Write-Host "[6] Post-Restart Tasks for WSL"
    Write-Host "----------------------------------------------" -ForegroundColor Green
    Write-Host "[0] Exit" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Green
}

function Execute-Script ($ScriptName) {
    $RepoBaseURL = "https://raw.githubusercontent.com/omar0801/PowerShell-Scripts/refs/heads/main"
    $ScriptURL = "$RepoBaseURL/$ScriptName"
    try {
        Write-Host "Executing $ScriptName..." -ForegroundColor Yellow
        Invoke-RestMethod -Uri $ScriptURL -OutFile "$env:TEMP\$ScriptName"
        Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File `"$env:TEMP\$ScriptName`""
    } catch {
        Write-Host "Error executing script `"$ScriptName`": $($_)" -ForegroundColor Red
    }
}

# Main Menu Loop
function Start-GUI {
    $menuScript = @"
while ($true) {
    Show-Menu
    \$choice = Read-Host "Choose a menu option using your keyboard [1,2,3,4,5,6,0]"

    switch (\$choice) {
        1 { Execute-Script "choco_remove.ps1" }
        2 { Execute-Script "UninstallWSL.ps1" }
        3 { Execute-Script "Windows.ps1" }
        4 { Execute-Script "EnableWSL.ps1" }
        5 { Execute-Script "installs.ps1" }
        6 { Execute-Script "PostRestartWSL.ps1" }
        0 { 
            Write-Host "Exiting..." -ForegroundColor Red
            break
        }
        default { Write-Host "Invalid option. Please try again." -ForegroundColor Yellow }
    }
    Start-Sleep -Seconds 2
}
"@

    # Save the menu script to a temporary file
    $tempScriptPath = Join-Path $env:TEMP "MenuScript.ps1"
    $menuScript | Set-Content -Path $tempScriptPath

    # Open a new PowerShell window to run the GUI
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$tempScriptPath`""
}

# Start the GUI
Start-GUI
