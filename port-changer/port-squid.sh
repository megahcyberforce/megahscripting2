#!/bin/bash
#Stunnel Port Changer

#Color
RED='\e[1;31m'
GREEN='\e[0;32m'
NC='\e[0m'

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
clear
sqd="$(cat /etc/squid/squid.conf | grep -i http_port | awk '{print $2}' | head -n1)"
sqd2="$(cat /etc/squid/squid.conf | grep -i http_port | awk '{print $2}' | tail -n1)"
echo -e "======================================" | lolcat
echo -e "        Squid Port Changer"
echo -e "     [1]  Change Port $sqd"
echo -e "     [2]  Change Port $sqd2"
echo -e "     [x]  Exit"
echo -e "======================================" | lolcat
echo -e ""
read -p "     Select From Options [1-2 or x] :  " prot
echo -e ""
case $prot in
1)
read -p "Please Input New Port For Squid: " squid
if [ -z $squid ]; then 
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $squid)
if [[ -z $cek ]]; then
sed -i "s/$sqd/$squid/g" /etc/squid/squid.conf
/etc/init.d/squid restart > /dev/null
echo -e "${GREEN}Succesfully Changed Port To $squid !${NC}"
else
echo "${RED}Error !${NC}Port $squid Is Already Used In Other Services !"
fi
;;
2)
read -p "Please Input New Port For Squid: " squid
if [ -z $squid ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $squid)
if [[ -z $cek ]]; then
sed -i "s/$sqd2/$squid/g" /etc/squid/squid.conf
/etc/init.d/squid restart > /dev/null
echo -e "${GREEN}Succesfully Changed Port To $squid !${NC}"
else
echo "${RED}Error !${NC}Port $squid Is Already Used In Other Services !"
fi
;;
x)
exit
menu
;;
*)
echo "Please enter an correct number"
;;
esac