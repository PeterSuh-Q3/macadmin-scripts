#!/bin/bash

# Function to read a yes/no answer
function readanswer() {
    while true; do
        read answ
        case $answ in
            [Yy]* ) answer="$answ"; break;;
            [Nn]* ) answer="$answ"; break;;
            * ) echo "Please answer y/Y or n/N.";;
        esac
    done
}

# Function to check if the recovery folder exists and prompt the user
check_recovery_folder() {
    if [ -d "./com.apple.recovery.boot" ]; then
        echo "The ./com.apple.recovery.boot folder exists. macOS will be overwritten. Is this okay? (y/n)"
        readanswer
        if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
            echo "Operation cancelled by user."
            return 1
        fi
    fi
    return 0
}

curl -kLO https://raw.githubusercontent.com/acidanthera/OpenCorePkg/refs/heads/master/Utilities/macrecovery/macrecovery.py
chmod +x macrecovery.py

echo 'Select a macOS recovery version:'
select option in "macOS Lion (10.7.5)" "macOS Mountain Lion (10.8.5)" "macOS Mavericks (10.9.5)" "macOS Yosemite (10.10.5)" "macOS El Capitan (10.11.6)" "macOS Sierra (10.12.6)" "macOS High Sierra (10.13.6)" "macOS Mojave (10.14.6)" "macOS Catalina (10.15.7)" "macOS Big Sur (11.7.10)" "macOS Monterey (12.7.6)" "macOS Ventura (13.7.1)" "macOS Sonoma (14.7.1)" "macOS Sequoia (15.1.1)" "Exit"
do
    case $REPLY in
        1) check_recovery_folder && ./macrecovery.py -b Mac-2E6FAB96566FE58C -m 00000000000F25Y00 download ;;
        2) check_recovery_folder && ./macrecovery.py -b Mac-7DF2A3B5E5D671ED -m 00000000000F65100 download ;;
        3) check_recovery_folder && ./macrecovery.py -b Mac-F60DEB81FF30ACF6 -m 00000000000FNN100 download ;;
        4) check_recovery_folder && ./macrecovery.py -b Mac-E43C1C25D4880AD6 -m 00000000000GDVW00 download ;;
        5) check_recovery_folder && ./macrecovery.py -b Mac-FFE5EF870D7BA81A -m 00000000000GQRX00 download ;;
        6) check_recovery_folder && ./macrecovery.py -b Mac-77F17D7DA9285301 -m 00000000000J0DX00 download ;;
        7) check_recovery_folder && ./macrecovery.py -b Mac-7BA5B2D9E42DDD94 -m 00000000000J80300 download ;;
        8) check_recovery_folder && ./macrecovery.py -b Mac-7BA5B2DFE22DDD8C -m 00000000000KXPG00 download ;;
        9) check_recovery_folder && ./macrecovery.py -b Mac-CFF7D910A743CAAF -m 00000000000PHCD00 download ;;
        10) check_recovery_folder && ./macrecovery.py -b Mac-2BD1B31983FE1663 -m 00000000000000000 download ;;
        11) check_recovery_folder && ./macrecovery.py -b Mac-E43C1C25D4880AD6 -m 00000000000000000 download ;;
        12) check_recovery_folder && ./macrecovery.py -b Mac-B4831CEBD52A0C4C -m 00000000000000000 download ;;
        13) check_recovery_folder && ./macrecovery.py -b Mac-827FAC58A8FDFA22 -m 00000000000000000 download ;;
        14) check_recovery_folder && ./macrecovery.py -b Mac-937A206F2EE63C01 -m 00000000000000000 download ;;
        15) echo "Exiting the menu."; break ;;
        *) echo "Invalid selection." ;;
    esac
done
