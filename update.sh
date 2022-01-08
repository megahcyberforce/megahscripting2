#!/bin/bash
#Update
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

# Color
RED="\e[1;31m"
GREEN="\e[0;32m"
NC="\e[0m"

# Validate Your IP Address

MYIP=$(wget -qO- icanhazip.com);
echo "Checking Auth For Permission"
IZIN=$( curl -s https://raw.githubusercontent.com/wakleman/ip/main/access | grep $MYIP )
if [[ $MYIP == "" ]]; then
    echo "No Database Founded !"
    exit 1
elif [[ $MYIP = $IZIN ]]; then
    echo -e "${GREEN}Granted !${NC} Your IP Adress Is Registered"
else
    echo -e "${RED}Denied !${NC} Your IP Adress Is Not Registered";
    echo "Please Contact Admin For Buying Scripts"
    exit 0
fi

rm -f setup.sh
rm -f setup-xray.sh 
rm -f webmin.sh 

cd /usr/bin

wget -O addwg "https://raw.githubusercontent.com/wakleman/wakleman1/main/update/addwg.sh"
wget -O addtrojan "https://raw.githubusercontent.com/wakleman/wakleman1/main/update/addtrojan.sh"
wget -O addtrgo "https://raw.githubusercontent.com/wakleman/wakleman1/main/update/addtrgo.sh"
chmod +x addwg
chmod +x addtrojan
chmod +x addtrgo
cd
clear
echo "Succesfully Apply New Update To System"