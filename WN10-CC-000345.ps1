 <#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Tracey B
    LinkedIn        : linkedin.com/in/tleanne/
    GitHub          : github.com/tleanne1
    Date Created    : 2025-03-11
    Last Modified   : 2025-03-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000345

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000345).ps1 
#>

# Define the registry path
$registryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service'

# Define the property name and desired value
$propertyName = 'AllowBasic'
$desiredValue = 0  # Corresponds to dword:00000000

# Check if the registry key exists; if not, create it
if (-not (Test-Path -Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the AllowBasic value to 0
New-ItemProperty -Path $registryPath -Name $propertyName -Value $desiredValue -PropertyType DWord -Force | Out-Null 
