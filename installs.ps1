function Prompt-Install {
    param (
        [string]$SoftwareName
    )

    $response = Read-Host ("Do you want to install `"$SoftwareName`"? (yes/no)")
    return $response -eq "yes"
}

$pythonInstallerPath = "$env:TEMP\python-installer.exe"
$gitInstallerPath = "$env:TEMP\git-installer.exe"

if (Prompt-Install -SoftwareName "Python") {
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
}

if (Prompt-Install -SoftwareName "Git") {

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
}

if (Prompt-Install -SoftwareName "Chocolatey") {

    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey not found. Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

        if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
            Write-Host "Chocolatey installation failed."
            exit 1
        }
    }
    Write-Host "Chocolatey installed successfully."

    function Install-Software {
        param (
            [string]$SoftwareName,
            [string]$ChocoPackageName
        )

        $response = Read-Host ("Do you want to install `"$SoftwareName`"? (yes/no)")
        if ($response -eq "yes") {
            Write-Host "Installing $SoftwareName using Chocolatey..."
            choco install $ChocoPackageName -y

            Write-Host "Verifying $SoftwareName installation..."
            if (Get-Command $ChocoPackageName -ErrorAction SilentlyContinue) {
                Write-Host "$SoftwareName installed successfully."
            } else {
                Write-Host "$SoftwareName installation failed."
            }
        } else {
            Write-Host "$SoftwareName installation skipped."
        }
    }

    Install-Software -SoftwareName "make" -ChocoPackageName "make"
    Install-Software -SoftwareName "vscode" -ChocoPackageName "vscode.install"
    Install-Software -SoftwareName "HWiNFO" -ChocoPackageName "hwinfo.install"
    Install-Software -SoftwareName "Discord" -ChocoPackageName "discord.install"
    Install-Software -SoftwareName "Steam" -ChocoPackageName "steam"
    Install-Software -SoftwareName "Valorant" -ChocoPackageName "valorant"
    Install-Software -SoftwareName "windscribe" -ChocoPackageName "windscribe"
}

Write-Host "Updating PATH environment variable..."
if ($pythonVersion) {
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Python$($pythonVersion.Split('.')[0])$($pythonVersion.Split('.')[1])\;C:\Program Files\Git\cmd\;C:\ProgramData\chocolatey\bin\", [System.EnvironmentVariableTarget]::Machine)
} elseif (Test-Path "C:\Program Files\Git\cmd\") {
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Git\cmd\;C:\ProgramData\chocolatey\bin\", [System.EnvironmentVariableTarget]::Machine)
} else {
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\ProgramData\chocolatey\bin\", [System.EnvironmentVariableTarget]::Machine)
}

Write-Host "Cleaning up..."
if (Test-Path $pythonInstallerPath) { Remove-Item -Path $pythonInstallerPath -Force }
if (Test-Path $gitInstallerPath) { Remove-Item -Path $gitInstallerPath -Force }

Write-Host "Installation process completed."
