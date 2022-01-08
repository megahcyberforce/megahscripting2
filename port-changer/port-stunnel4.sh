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
ssl="$(cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $1}')"
ssl2="$(cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $2}')"
echo -e "======================================" 
echo -e "        Stunnel4 Port Changer"
echo -e "     [1]  Change Port $ssl"
echo -e "     [2]  Change Port $ssl2"
echo -e "     [x]  Exit"
echo -e "======================================" 
echo -e ""
read -p "     Select From Options [1-2 or x] :  " port
echo -e ""
case $port in
1)
read -p "Input New Port For Stunnel4: " stl
if [ -z $stl ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $stl)
if [[ -z $cek ]]; then
sed -i "s/$ssl/$stl/g" /etc/stunnel/stunnel.conf
/etc/init.d/stunnel4 restart > /dev/null
echo -e "${GREEN}Succesfully Changed Stunnel4 Port To${NC} $stl"
else
echo "${RED}Error !${NC} Port $stl Is Already Used By Other Service !"
fi
;;
2)
read -p "Input New Port For Stunnel4: " stl
if [ -z $stl ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $stl)
if [[ -z $cek ]]; then
sed -i "s/$ssl2/$stl/g" /etc/stunnel/stunnel.conf
/etc/init.d/stunnel4 restart > /dev/null
echo -e "${GREEN}Succesfully Changed Stunnel4 Port To${NC} $stl"
else
echo "${RED}Error !${NC} Port $stl Is Already Used By Other Service !"
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