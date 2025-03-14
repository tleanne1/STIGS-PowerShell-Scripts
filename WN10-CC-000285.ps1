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
    STIG-ID         : WN10-CC-000285 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-CC-000285).ps1 
#>


# Define registry paths and their corresponding values
$registrySettings = @{
    'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' = @{
        'KeepAliveEnable'     = 1
        'KeepAliveInterval'   = 1
        'fEncryptRPCTraffic'  = 1
    }
    'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client' = @{
        'fEnableUsbBlockDeviceBySetupClass'    = 1
        'fEnableUsbNoAckIsochWriteToDevice'    = 80
        'fEnableUsbSelectDeviceByInterface'    = 1
    }
    'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client\UsbBlockDeviceBySetupClasses' = @{
        '1000' = '{3376f4ce-ff8d-40a2-a80f-bb4359d1415c}'
    }
    'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client\UsbSelectDeviceByInterfaces' = @{
        '1000' = '{6bdd1fc6-810f-11d0-bec7-08002be2092f}'
    }
}

# Iterate over each registry path and set the corresponding values
foreach ($path in $registrySettings.Keys) {
    # Check if the registry path exists; if not, create it
    if (-not (Test-Path $path)) {
        New-Item -Path $path -Force | Out-Null
    }

    # Set each property within the registry path
    foreach ($name in $registrySettings[$path].Keys) {
        $value = $registrySettings[$path][$name]

        # Determine the property type based on the value
        if ($value -is [int]) {
            $propertyType = 'DWord'
        } elseif ($value -is [string]) {
            $propertyType = 'String'
        } else {
            Write-Host "Unsupported value type for $name in $path. Skipping..."
            continue
        }

        # Set the registry property
        New-ItemProperty -Path $path -Name $name -Value $value -PropertyType $propertyType -Force | Out-Null
    }
}

Write-Host "Registry settings have been successfully applied."
 
