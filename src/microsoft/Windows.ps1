# Run the script entirely within the same PowerShell session
# Define the URL to fetch and execute
$scriptUrl = "https://get.activated.win"

# Clear any existing output for clarity
Clear-Host

# Inform the user
Write-Host "Downloading and executing script from $scriptUrl..." -ForegroundColor Cyan

# Execute the script inline
try {
    # Use Invoke-RestMethod (irm) to fetch the script content and execute it
    (Invoke-RestMethod -Uri $scriptUrl) | Invoke-Expression
    Write-Host "Script executed successfully." -ForegroundColor Green
} catch {
    Write-Host "An error occurred while executing the script: $_" -ForegroundColor Red
}

# Return to the main menu instead of exiting the session
# Replace this with the function or logic that displays the main menu
Show-MainMenu
