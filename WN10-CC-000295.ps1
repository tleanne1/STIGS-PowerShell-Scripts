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
    STIG-ID         : WN10-CC-000295

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000295).ps1 
#>

# Define the registry path
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds'

# Define the property name and value
$PropertyName = 'DisableEnclosureDownload'
$PropertyValue = 1

# Check if the registry path exists; if not, create it
if (-not (Test-Path -Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Set the registry property value (using Set-ItemProperty for overwrite behavior)
Set-ItemProperty -Path $RegistryPath -Name $PropertyName -Value $PropertyValue -Force

 
