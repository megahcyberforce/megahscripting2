#!/bin/bash
#Port Changer XRay

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

xray=$(cat /etc/xray-mini/config.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/       //g')
echo -e "======================================"
echo -e "         XRay Port Changer"
echo -e ""
echo -e "     [1]  Change Port Xray Vless ${RED}$xray${NC}"
echo -e "     [x]  Exit"
echo -e ""
echo -e "======================================"
echo -e ""
read -p "     Select From Options [1 or x] :  " port
echo -e ""
case $port in
1)
read -p "Type New Port For V2Ray TLS: " xray1
if [ -z $xray1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $xray1)
if [[ -z $cek ]]; then
sed -i "s/$xray/$xray1/g" /etc/xray-mini/config.json
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $xray -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $xray -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $xray1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $xray1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray-mini > /dev/null
clear
echo -e "${GREEN}Succesfully Changed XRay Port To $xray1${NC}"
else
echo -e "${RED}Error ! ${NC}Port $xray1 Is Already Used"
fi
;;
esac