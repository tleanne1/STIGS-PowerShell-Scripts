 <#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Tracey B
    LinkedIn        : linkedin.com/in/tleanne/
    GitHub          : github.com/tleanne1
    Date Created    : 2025-03-14
    Last Modified   : 2025-03-14
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000197 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000197).ps1 
#>

# Define the registry path and value
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
$ValueName = 'DisableWindowsConsumerFeatures'
$ValueData = 1  # Disable Windows Consumer Features

# Check if the registry path exists; if not, create it
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows' -Name 'CloudContent' -Force
}

# Check if the registry value exists
if (Get-ItemProperty -Path $RegistryPath -Name $ValueName -ErrorAction SilentlyContinue) {
    # If the value exists, use Set-ItemProperty to modify it
    Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -Force
} else {
    # If the value does not exist, use New-ItemProperty to create it with the correct type
    New-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -PropertyType DWord -Force
}

Write-Host "Windows Consumer Features have been disabled."
 
