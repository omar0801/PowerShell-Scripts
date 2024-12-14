param (
    [string]$PackageName
)

# Function to install Python
function Install-Python {
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
        Write-Host "Python installation failed. Python executable not found at $pythonExePath"
    }

    if (Test-Path $pythonInstallerPath) { Remove-Item -Path $pythonInstallerPath -Force }
}

# Function to install Git
function Install-Git {
    Write-Host "Installing Git..."
    $gitInstallerPath = "$env:TEMP\\git-installer.exe"

    Write-Host "Fetching the latest Git installer URL..."
    $gitReleasesApi = "https://api.github.com/repos/git-for-windows/git/releases/latest"
    $gitRelease = Invoke-RestMethod -Uri $gitReleasesApi -Headers @{ "User-Agent" = "PowerShell" }
    $gitInstallerUrl = ($gitRelease.assets | Where-Object { $_.name -match "64-bit.exe" }).browser_download_url

    if (-not $gitInstallerUrl) {
        Write-Error "Failed to fetch the latest Git installer URL."
        exit 1
    }
    Write-Host "Latest Git installer URL: $gitInstallerUrl"

    Write-Host "Downloading Git installer..."
    Invoke-WebRequest -Uri $gitInstallerUrl -OutFile $gitInstallerPath -UseBasicParsing

    Write-Host "Installing Git..."
    Start-Process -FilePath $gitInstallerPath -ArgumentList "/SILENT" -Wait

    Write-Host "Verifying Git installation..."
    $gitExePath = "C:\Program Files\Git\cmd\git.exe"
    if (Test-Path $gitExePath) {
        $gitVersion = & $gitExePath --version 2>&1
        Write-Host "Git installed successfully: $gitVersion"
    } else {
        Write-Host "Git installation failed. Git executable not found at $gitExePath"
    }

    if (Test-Path $gitInstallerPath) { Remove-Item -Path $gitInstallerPath -Force }
}

# Function to install Chocolatey
function Install-Chocolatey {
    Write-Host "Installing Chocolatey..."
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
            Write-Error "Chocolatey installation failed."
            exit 1
        }
    }
    Write-Host "Chocolatey installed successfully."
}

# Generic function to install packages via Chocolatey
function Install-ChocoPackage {
    param (
        [string]$AppName,
        [string]$ChocoPackageName
    )
    Write-Host "Installing $AppName via Chocolatey..."
    choco install $ChocoPackageName -y

    Write-Host "Verifying $AppName installation..."
    if (Get-Command $ChocoPackageName -ErrorAction SilentlyContinue) {
        Write-Host "$AppName installed successfully."
    } else {
        Write-Host "$AppName installation failed."
    }
}

# Main Logic: Handle $PackageName Parameter
switch ($PackageName) {
    "Python"        { Install-Python }
    "Git"           { Install-Git }
    "Chocolatey"    { Install-Chocolatey }
    "make"          { Install-ChocoPackage -AppName "make" -ChocoPackageName "make" }
    "VSCode"        { Install-ChocoPackage -AppName "VSCode" -ChocoPackageName "vscode.install" }
    "HWiNFO"        { Install-ChocoPackage -AppName "HWiNFO" -ChocoPackageName "hwinfo.install" }
    "Discord"       { Install-ChocoPackage -AppName "Discord" -ChocoPackageName "discord.install" }
    "Steam"         { Install-ChocoPackage -AppName "Steam" -ChocoPackageName "steam" }
    "Valorant"      { Install-ChocoPackage -AppName "Valorant" -ChocoPackageName "valorant" }
    "Windscribe"    { Install-ChocoPackage -AppName "Windscribe" -ChocoPackageName "windscribe" }
    default {
        Write-Host "Invalid Package Name: $PackageName"
        exit 1
    }
}
