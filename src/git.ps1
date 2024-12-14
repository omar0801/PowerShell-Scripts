# Function to install Git
function Install-Git {
    try {
        Write-Host "Starting Git installation process..." -ForegroundColor Green
        
        $gitInstallerPath = "$env:TEMP\\git-installer.exe"

        # Fetch the latest Git release information
        Write-Host "Fetching the latest Git installer URL..."
        $gitReleasesApi = "https://api.github.com/repos/git-for-windows/git/releases/latest"
        $gitRelease = Invoke-RestMethod -Uri $gitReleasesApi -Headers @{ "User-Agent" = "PowerShell" }

        # Extract the 64-bit Git installer URL
        $gitInstallerUrl = ($gitRelease.assets | Where-Object { $_.name -match "64-bit.exe" }).browser_download_url

        if (-not $gitInstallerUrl) {
            Write-Error "Failed to fetch the latest Git installer URL."
            return
        }
        Write-Host "Latest Git installer URL: $gitInstallerUrl" -ForegroundColor Cyan

        # Download the installer
        Write-Host "Downloading Git installer to $gitInstallerPath..."
        Invoke-WebRequest -Uri $gitInstallerUrl -OutFile $gitInstallerPath -UseBasicParsing

        # Execute the installer silently
        Write-Host "Installing Git silently..."
        Start-Process -FilePath $gitInstallerPath -ArgumentList "/SILENT" -Wait

        # Verify the installation
        Write-Host "Verifying Git installation..."
        $gitExePath = "C:\Program Files\Git\cmd\git.exe"
        if (Test-Path $gitExePath) {
            $gitVersion = & $gitExePath --version 2>&1
            Write-Host "Git installed successfully: $gitVersion" -ForegroundColor Green
        } else {
            Write-Error "Git installation failed. Git executable not found at $gitExePath"
        }

        # Clean up the installer file
        if (Test-Path $gitInstallerPath) {
            Write-Host "Cleaning up installer..."
            Remove-Item -Path $gitInstallerPath -Force
        }

    } catch {
        Write-Error "An error occurred during the Git installation process: $_"
    }
}

# Call the function to install Git
Install-Git
