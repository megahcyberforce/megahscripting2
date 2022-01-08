#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
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
if [[ "$IP2" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP2
fi
IP=$(wget -qO- icanhazip.com);
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=1
echo Checking Acces
sleep 0.5
echo Permission Accepted
clear
sleep 0.5
echo Username: $Login
sleep 0.5
echo Password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
created=`date -d "0 days" +"%d-%m-%Y"`
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e "Succesfully Create ${RED}SSH/OPenVPN Trial Accounts${NC}"
echo -e "Here Your Accounts Details :"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}Accounts Information ${NC}"
echo -e "${GREEN}Username${NC} : $Login"
echo -e "${GREEN}Password${NC} : $Pass"
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
