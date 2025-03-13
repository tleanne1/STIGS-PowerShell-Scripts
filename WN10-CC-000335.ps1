 <#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Tracey B
    LinkedIn        : linkedin.com/in/tleanne/
    GitHub          : github.com/tleanne1
    Date Created    : 2025-03-12
    Last Modified   : 2025-03-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000335

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000335).ps1 
#>

# Define the registry path and value name
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client'
$ValueName = 'AllowUnencryptedTraffic'
$ValueData = 0  # Disable unencrypted traffic

# Check if the registry path exists; if not, create it
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM' -Name 'Client' -Force
}

# Set the registry value
New-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -PropertyType DWord -Force

Write-Host "Registry value '$ValueName' set to $ValueData successfully at '$RegistryPath'."
 
