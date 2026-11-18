function Uninstall-Chocolatey {
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
    $chocoBin = "$chocoPath\bin"
    $envPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
    # Split PATH into entries and drop the Chocolatey one; this works wherever it sits
    # (including last, with no trailing ';') and with or without a trailing '\'
    $newPath = ($envPath -split ';' | Where-Object { $_ -and $_.TrimEnd('\') -ne $chocoBin }) -join ';'
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
    # Also update the current session so the verification below sees the change
    $env:Path = ($env:Path -split ';' | Where-Object { $_ -and $_.TrimEnd('\') -ne $chocoBin }) -join ';'
    Write-Host "Chocolatey removed from PATH." -ForegroundColor Green

    Write-Host "Verifying Chocolatey removal..."
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey successfully removed." -ForegroundColor Green
    } else {
        Write-Host "Chocolatey removal failed. Please check manually." -ForegroundColor Red
    }
}

# Run the function immediately
Uninstall-Chocolatey
