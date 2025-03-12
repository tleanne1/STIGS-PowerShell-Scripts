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
    STIG-ID         : WN10-AU-000505

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000505).ps1 
#>

# Define the registry key and value
$regKeyPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security'
$regValueName = 'MaxSize'
$regValueData = 1024000  # Size in bytes (1,000,000 bytes)

# Check if the registry key exists; if not, create it
if (-not (Test-Path $regKeyPath)) {
    New-Item -Path $regKeyPath -Force
}

# Set the MaxSize value
Set-ItemProperty -Path $regKeyPath -Name $regValueName -Value $regValueData -Type DWord

Write-Host "Security event log MaxSize set to $regValueData bytes."
 
