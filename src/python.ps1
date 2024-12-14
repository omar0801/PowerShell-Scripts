# Function to install Python
function Install-Python {
    if (Check-Python) {
        Write-Host "Skipping Python installation as it is already installed."
        return
    }

    Write-Host "Installing Python..."
    $pythonInstallerPath = "$env:TEMP\\python-installer.exe"

    Write-Host "Fetching the latest Python installer URL..."
    $pythonDownloadPage = Invoke-WebRequest -Uri "https://www.python.org/downloads/" -UseBasicParsing
    $pythonInstallerUrl = ($pythonDownloadPage.Links | Where-Object { $_.href -match "https://www.python.org/ftp/python/.+/python-.+-amd64.exe" }).href

    if (-not $pythonInstallerUrl) {
        Write-Error "Failed to fetch the latest Python installer URL."
        exit 1
    }
    Write-Host "Latest Python installer URL: $pythonInstallerUrl"

    $pythonVersion = ($pythonInstallerUrl -split "/")[-2]
    $pythonExePath = "C:\Program Files\Python$($pythonVersion.Split('.')[0])$($pythonVersion.Split('.')[1])\python.exe"

    Write-Host "Downloading Python installer..."
    Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $pythonInstallerPath -UseBasicParsing

    Write-Host "Installing Python..."
    Start-Process -FilePath $pythonInstallerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

    Write-Host "Verifying Python installation..."
    if (Test-Path $pythonExePath) {
        $pythonVersionOutput = & $pythonExePath --version 2>&1
        Write-Host "Python installed successfully: $pythonVersionOutput"
    } else {
        Write-Error "Python installation failed. Python executable not found at $pythonExePath"
    }

    if (Test-Path $pythonInstallerPath) { Remove-Item -Path $pythonInstallerPath -Force }
}

# Call the Install-Python function
Install-Python
