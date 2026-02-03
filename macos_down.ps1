# Function to read a yes/no answer
function Read-Answer {
    do {
        $answ = Read-Host
        switch -Regex ($answ.ToLower()) {
            '^y(es)?$' { return $true }
            '^n(o)?$' { return $false }
            default { Write-Host "Please answer with y or n." }
        }
    } while ($true)
}

# Function to check if the recovery folder exists and prompt the user
function Check-RecoveryFolder {
    if (Test-Path -Path ".\com.apple.recovery.boot") {
        Write-Host "The .\com.apple.recovery.boot folder exists. macOS will be overwritten. Do you want to continue? (y/n)"
        if (-not (Read-Answer)) {
            Write-Host "Operation cancelled by user."
            return $false
        }
    }
    return $true
}

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/acidanthera/OpenCorePkg/master/Utilities/macrecovery/macrecovery.py" -OutFile "macrecovery.py"

Write-Host 'Select a macOS recovery version:'
$options = @(
    "macOS Lion (10.7.5)",
    "macOS Mountain Lion (10.8.5)",
    "macOS Mavericks (10.9.5)",
    "macOS Yosemite (10.10.5)",
    "macOS El Capitan (10.11.6)",
    "macOS Sierra (10.12.6)",
    "macOS High Sierra (10.13.6)",
    "macOS Mojave (10.14.6)",
    "macOS Catalina (10.15.7)",
    "macOS Big Sur (11.7.10)",
    "macOS Monterey (12.7.4)",
    "macOS Ventura (13.7.8)",
    "macOS Sonoma (14.8.3)",
    "macOS Sequoia (15.7.3)",
    "macOS Tahoe (26.2)",
    "Exit"
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)

for ($i = 0; $i -lt $options.Count; $i++) {
    Write-Host "$($i+1): $($options[$i])"
}

do {
    $selection = Read-Host "Please select a number"
    switch ($selection) {
        1 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-2E6FAB96566FE58C -m 00000000000F25Y00 download } }
        2 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-7DF2A3B5E5D671ED -m 00000000000F65100 download } }
        3 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-F60DEB81FF30ACF6 -m 00000000000FNN100 download } }
        4 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-E43C1C25D4880AD6 -m 00000000000GDVW00 download } }
        5 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-FFE5EF870D7BA81A -m 00000000000GQRX00 download } }
        6 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-77F17D7DA9285301 -m 00000000000J0DX00 download } }
        7 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-7BA5B2D9E42DDD94 -m 00000000000J80300 download } }
        8 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-7BA5B2DFE22DDD8C -m 00000000000KXPG00 download } }
        9 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-CFF7D910A743CAAF -m 00000000000PHCD00 download } }
        10 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-2BD1B31983FE1663 -m 00000000000000000 download } }
        11 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-E43C1C25D4880AD6 -m 00000000000000000 download } }
        12 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-B4831CEBD52A0C4C -m 00000000000000000 download } }
        13 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-827FAC58A8FDFA22 -m 00000000000000000 download } }
        14 { if (Check-RecoveryFolder) { python3 macrecovery.py -b Mac-937A206F2EE63C01 -m 00000000000000000 download } }
        15 { Write-Host "Exiting the menu."; break }
        default { Write-Host "Invalid selection." }
    }
} while ($selection -ne 15)
