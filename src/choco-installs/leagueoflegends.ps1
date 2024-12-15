# Default Chocolatey Installer Script

# Function to check if Chocolatey is installed
function Check-Chocolatey {
    try {
        choco -v > $null 2>&1
        return $true
    } catch {
        return $false
    }
}

# Install Chocolatey if not already installed
function Install-Chocolatey {
    Write-Host "Chocolatey is not installed. Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));
    Write-Host "Chocolatey installation complete."
}

# Function to install a package using Chocolatey
function Install-Package {
    param (
        [string]$PackageName
    )

    Write-Host "Installing package: $PackageName"
    choco install $PackageName -y
    if ($?) {
        Write-Host "$PackageName installation complete."
    } else {
        Write-Host "Failed to install $PackageName."
    }
}

# Main script logic
if (!(Check-Chocolatey)) {
    Install-Chocolatey
} else {
    Write-Host "Chocolatey is already installed."
}

# Specify the package to install 
$PackageToInstall = "leagueoflegends"
Install-Package -PackageName $PackageToInstall
