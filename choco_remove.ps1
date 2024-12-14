function Prompt-Uninstall {
    param (
        [string]$SoftwareName
    )

    $response = Read-Host ("Do you want to uninstall `"$SoftwareName`"? (yes/no)")
    return $response -eq "yes"
}

# Prompt for Chocolatey uninstallation
if (Prompt-Uninstall -SoftwareName "Chocolatey") {
    # Uninstall all Chocolatey packages (optional)
    Write-Host "Uninstalling all Chocolatey packages..."
    choco uninstall all -y

    # Remove the Chocolatey installation folder
    Write-Host "Removing Chocolatey installation folder..."
    $chocoPath = "C:\ProgramData\chocolatey"
    if (Test-Path $chocoPath) {
        Remove-Item -Recurse -Force $chocoPath
        Write-Host "Chocolatey folder removed."
    } else {
        Write-Host "Chocolatey folder not found."
    }

    # Remove Chocolatey from the PATH environment variable
    Write-Host "Removing Chocolatey from PATH..."
    $envPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
    $newPath = $envPath -replace [regex]::Escape("C:\ProgramData\chocolatey\bin;"), ""
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Chocolatey removed from PATH."

    # Verify Chocolatey removal
    Write-Host "Verifying Chocolatey removal..."
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey successfully removed."
    } else {
        Write-Host "Chocolatey removal failed. Please check manually."
    }
} else {
    Write-Host "Chocolatey uninstallation skipped."
}
