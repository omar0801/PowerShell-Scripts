# Function to install Python
function Install-Python {
    try {
        Write-Host "Starting Python installation process..." -ForegroundColor Green
        
        $pythonInstallerPath = "$env:TEMP\\python-installer.exe"

        Write-Host "Fetching the latest Python installer URL..."
        $pythonDownloadPage = Invoke-WebRequest -Uri "https://www.python.org/downloads/" -UseBasicParsing
        
        # Find the correct link for the Python installer
        $pythonInstallerUrl = ($pythonDownloadPage.Links | Where-Object {
            $_.href -match "https://www.python.org/ftp/python/.+/python-.+-amd64.exe"
        }).href

        if (-not $pythonInstallerUrl) {
            Write-Error "Failed to fetch the latest Python installer URL."
            return
        }
        Write-Host "Latest Python installer URL: $pythonInstallerUrl" -ForegroundColor Cyan

        # Extract Python version from the URL
        $pythonVersion = ($pythonInstallerUrl -split "/")[-2]
        $majorVersion = $pythonVersion.Split('.')[0]
        $minorVersion = $pythonVersion.Split('.')[1]
        $pythonExePath = "C:\Program Files\Python${majorVersion}${minorVersion}\python.exe"

        # Download the installer
        Write-Host "Downloading Python installer to $pythonInstallerPath..."
        Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $pythonInstallerPath -UseBasicParsing

        # Execute the installer silently
        Write-Host "Installing Python silently..."
        Start-Process -FilePath $pythonInstallerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

        # Verify the installation
        Write-Host "Verifying Python installation..."
        if (Test-Path $pythonExePath) {
            $pythonVersionOutput = & $pythonExePath --version 2>&1
            Write-Host "Python installed successfully: $pythonVersionOutput" -ForegroundColor Green
        } else {
            Write-Error "Python installation failed. Python executable not found at $pythonExePath"
        }

        # Clean up the installer file
        if (Test-Path $pythonInstallerPath) {
            Write-Host "Cleaning up installer..."
            Remove-Item -Path $pythonInstallerPath -Force
        }

    } catch {
        Write-Error "An error occurred during the installation process: $_"
    }
}

# Call the function to install Python
Install-Python
