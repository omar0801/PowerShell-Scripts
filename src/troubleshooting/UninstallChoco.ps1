function Uninstall-Chocolatey {
    Write-Host "WARNING: This will uninstall Chocolatey and all apps installed through it." -ForegroundColor Red
    Write-Host "Uninstalling all Chocolatey packages..."
    choco uninstall all -y

    Write-Host "Removing Chocolatey installation folder..."
    $chocoPath = "C:\ProgramData\chocolatey"
    if (Test-Path $chocoPath) {
        Remove-Item -Recurse -Force $chocoPath
        Write-Host "Chocolatey folder removed." -ForegroundColor Green
    } else {
        Write-Host "Chocolatey folder not found." -ForegroundColor Yellow
    }

    Write-Host "Removing Chocolatey from PATH..."
    $envPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
    $newPath = $envPath -replace [regex]::Escape("C:\\ProgramData\\chocolatey\\bin;"), ""
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Chocolatey removed from PATH." -ForegroundColor Green

    Write-Host "Verifying Chocolatey removal..."
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey successfully removed." -ForegroundColor Green
    } else {
        Write-Host "Chocolatey removal failed. Please check manually." -ForegroundColor Red
    }
    Pause
}
