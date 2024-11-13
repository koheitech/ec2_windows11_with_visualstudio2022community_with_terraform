<powershell>
# Enable logging
$logPath = "C:\install_log.txt"
Start-Transcript -Path $logPath -Append

Write-Output "Starting script execution..."

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force
Write-Output "Setting security protocol and starting Chocolatey installation..."
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Wait for Chocolatey to be available
Write-Output "Waiting for Chocolatey installation to complete..."
Start-Sleep -Seconds 10

# Check if Chocolatey installed successfully
if (Get-Command choco -ErrorAction SilentlyContinue) {
    Write-Output "Chocolatey installed successfully."

    # Install Visual Studio
    Write-Output "Starting Visual Studio installation..."
    choco install visualstudio2022community -y
    
    # Confirm Visual Studio installation started
    if ($? -eq $true) {
        Write-Output "Visual Studio installation initiated successfully."
    } else {
        Write-Output "Visual Studio installation failed to initiate."
    }
} else {
    Write-Output "Chocolatey installation failed."
}

Write-Output "Script execution completed."
Stop-Transcript

# Output location of the log file
Write-Output "Log file saved at $logPath"
</powershell>