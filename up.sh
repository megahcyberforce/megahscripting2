#!/bin/bash
#Update
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
ver=$(curl -s https://raw.githubusercontent.com/wakleman/wakleman1/main/version)
vernow=$(cat /home/ver)
if [ $vernow = $ver ]; then
echo -e "${red}Your Script Already Latest Version !${NC}"
exit
fi
echo -e "${green}New Update Is Available !${NC}"
read -p $'\e[32mPress Enter To Continue \e[0m: '
rm setup.sh
rm update.sh
rm webmin.sh
wget https://raw.githubusercontent.com/wakleman/wakleman1/main/update.sh
chmod +x update.sh
./update.sh
echo "$ver" > /home/ver
rm update.sh
clear
echo "${green}Succesfully Update To Latest Version !${nc}"