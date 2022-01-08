#!/bin/bash
# Add SSH
# ==================

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

# Read User
clear
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (days): " masaaktif

# IP
IP=$(curl -s ipinfo.io/ip);

# Stunnel Port
stunnel1=$( cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 3 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $1}' )
stunnel2=$( cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 3 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $2}' )
stunnel3=$( cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 3 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $3}' )

# Squid Port
squid1=$( cat /etc/squid/squid.conf | grep http_port | awk '{print $2}' | head -n1 )
squid2=$( cat /etc/squid/squid.conf | grep http_port | awk '{print $2}' | tail -n1)

# OpenVPN Port
ovpn_tcp="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn_udp="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"

# OHP Port
ohp=$(netstat -nlpt | grep -i ohp | grep -i ::: | sed 's/::://g'| awk '{print $4}')

source /var/lib/pakyavpn/ipvps.txt
domain=$(cat /etc/v2ray/domain )

clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e "Succesfully Create ${RED}SSH/OPenVPN Accounts${NC}"
echo -e "Here Your Accounts Details :"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}Accounts Information ${NC}"
echo -e "${GREEN}Username${NC} : $Login"
echo -e "${GREEN}Password${NC} : $Pass"
echo -e "${GREEN}Expired ${NC} : $exp"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}IP Adress & Domain Information ${NC}"
echo -e "${GREEN}IP Address${NC} :$IP"
echo -e "${GREEN}Domain${NC} : $domain"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}Port Information ${NC}"
echo -e "${GREEN}OPenSSH${NC} : 22"
echo -e "${GREEN}DropBear${NC} : 109 , 143"
echo -e "${GREEN}SSL/TLS${NC} : $stunnel1,$stunnel2"
echo -e "${GREEN}Squid${NC} : $squid1,$squid2"
echo -e "${GREEN}OPenVPN TCP $ovpn_tcp ${NC} : http://$IP:81/client-tcp-$ovpn_tcp.ovpn"
echo -e "${GREEN}OPenVPN UDP $ovpn_udp ${NC} : http://$IP:81/client-tcp-$ovpn_udp.ovpn"
echo -e "${GREEN}OPenVPN SSL $ovpn_stunnel3 ${NC} : http://$IP:81/client-tcp-ssl.ovpn"
echo -e "${GREEN}OPenVPN OHP $ohp ${NC} : http://$IP:81/client-tcp-ohp.ovpn"
echo -e "${GREEN}BadVPN${NC} : 7100-7300"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}Script By PakyaVPN${NC}"
echo -e "${GREEN}t.me/anakjati567${NC}"
echo -e "${RED}===================================================${NC}"
read -p "Press Enter For Back To SSH/OPenVPN Menu/ CTRL+C To Cancel : "
ssh-menu
