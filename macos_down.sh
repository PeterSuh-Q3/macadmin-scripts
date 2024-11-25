#!/bin/bash

echo 'Select a macOS recovery version:'
select option in "Lion (Latest version: 10.7.5)" "Mountain Lion (Latest version: 10.8.5)" "Mavericks (Latest version: 10.9.5)" "Yosemite (Latest version: 10.10.5)" "El Capitan (Latest version: 10.11.6)" "Sierra (Latest version: 10.12.6)" "High Sierra (Latest version: 10.13.6)" "Mojave (Latest version: 10.14.6)" "Catalina (Latest version: 10.15.7)" "Big Sur (Latest version: 11.7.10)" "Monterey (Latest version: 12.7.6)" "Ventura (Latest version: 13.7.1)" "Sonoma (Latest version: 14.7.1)" "Sequoia (Latest version: 15.1.1)" "Exit"
do
    case $REPLY in
        1) ./macrecovery.py -b Mac-2E6FAB96566FE58C -m 00000000000F25Y00 download ;;
        2) ./macrecovery.py -b Mac-7DF2A3B5E5D671ED -m 00000000000F65100 download ;;
        3) ./macrecovery.py -b Mac-F60DEB81FF30ACF6 -m 00000000000FNN100 download ;;
        4) ./macrecovery.py -b Mac-E43C1C25D4880AD6 -m 00000000000GDVW00 download ;;
        5) ./macrecovery.py -b Mac-FFE5EF870D7BA81A -m 00000000000GQRX00 download ;;
        6) ./macrecovery.py -b Mac-77F17D7DA9285301 -m 00000000000J0DX00 download ;;
        7) ./macrecovery.py -b Mac-7BA5B2D9E42DDD94 -m 00000000000J80300 download ;;
        8) ./macrecovery.py -b Mac-7BA5B2DFE22DDD8C -m 00000000000KXPG00 download ;;
        9) ./macrecovery.py -b Mac-CFF7D910A743CAAF -m 00000000000PHCD00 download ;;
        10) ./macrecovery.py -b Mac-2BD1B31983FE1663 -m 00000000000000000 download ;;
        11) ./macrecovery.py -b Mac-E43C1C25D4880AD6 -m 00000000000000000 download ;;
        12) ./macrecovery.py -b Mac-B4831CEBD52A0C4C -m 00000000000000000 download ;;
        13) ./macrecovery.py -b Mac-827FAC58A8FDFA22 -m 00000000000000000 download ;;
        14) ./macrecovery.py -b Mac-937A206F2EE63C01 -m 00000000000000000 download ;;
        15) echo "Exiting the menu."; break ;;
        *) echo "Invalid selection." ;;
    esac
done
