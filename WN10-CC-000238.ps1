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
    STIG-ID         : WN10-CC-000238

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000238).ps1 
#>

# Define the base registry path
$baseRegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge'

# Define the subkey path for Internet Settings
$internetSettingsPath = Join-Path -Path $baseRegistryPath -ChildPath 'Internet Settings'

# Define the property name and desired value
$propertyName = 'PreventCertErrorOverrides'
$desiredValue = 1  # Corresponds to dword:00000001

# Check if the base registry key exists; if not, create it
if (-not (Test-Path -Path $baseRegistryPath)) {
    New-Item -Path $baseRegistryPath -Force | Out-Null
}

# Check if the Internet Settings subkey exists; if not, create it
if (-not (Test-Path -Path $internetSettingsPath)) {
    New-Item -Path $internetSettingsPath -Force | Out-Null
}

# Set the PreventCertErrorOverrides value to 1
New-ItemProperty -Path $internetSettingsPath -Name $propertyName -Value $desiredValue -PropertyType DWord -Force | Out-Null
