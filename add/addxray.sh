#!/bin/bash

# Color
RED="\e[1;31m"
GREEN="\e[0;32m"
NC="\e[0m"

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

# // Input
read -p "Username   : " username
read -p "Expired    : " expired

domain=$(cat /root/domain)
uuid=$(cat /proc/sys/kernel/random/uuid)
exp=`date -d "$expired days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
port=$(cat /etc/xray-mini/config.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/       //g')

# // Input Data User Ke XRay Vless TCP XTLS
sed -i '/#XRay$/a\#DEPAN '"Username : $username | Expired : $exp"'\
            },{"id": "'""$uuid""'","flow": "'xtls-rprx-direct'"\
#BELAKANG '"Username : $username | Expired : $exp"'' /etc/xray-mini/config.json

IP=$( curl -s ipinfo.io/ip )

systemctl restart xray-mini
clear

echo -e "Succesfully Create ${RED}VLess/XRay${NC} Accounts"
echo -e "Here Your Accounts Details :"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}IP Address${NC} : $IP"
echo -e "${GREEN}Port ${NC} : $port"
echo -e "${GREEN}Domain${NC} : ${domain}"
echo -e "${GREEN}UUID${NC} : $uuid"
echo -e "${GREEN}Expired Date${NC} : $exp"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}VLess/XRay Config Link${NC}"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}VLess/XTLS Direct Configuration Link${NC}"
echo " vless://$uuid@$domain:$port?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=example.com#$username"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}VLess/XTLS Direct UDP Configuration Link${NC}"
echo " vless://$uuid@$domain:$port?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct-udp443&sni=example.com#$username"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}VLess/XTLS Splice Configuration Link${NC}"
echo " vless://$uuid@$domain:$port?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=example.com#$username"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}VLess/XTLS Splice UDP Configuration Link${NC}"
echo " vless://$uuid@$domain:$port?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice-udp443&sni=example.com#$username"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}Script By PakyaVPN${NC}"
echo -e "${GREEN}t.me/anakjati567${NC}"
echo -e "${RED}===================================================${NC}"
read -p "Press Enter For Back To VLess/XRay Menu/ CTRL+C To Cancel : "
xray-menu

