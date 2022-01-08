#!/bin/bash
# Trojan
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

clear
IP=$( curl -s ipinfo.io/ip );
uuid=$(cat /etc/trojan/uuid.txt)
source /var/lib/pakyavpn/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
fi
tr=$(cat /etc/trojan/config.json | grep local_port | sed 's/local_//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/"//g' | sed 's/   //g' | sed 's/  //g')
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "Password: " -e user
		user_EXISTS=$(grep -w $user /etc/trojan/akun.conf | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
domain=$(cat /etc/v2ray/domain)
read -p "Expired (days): " masaaktif
sed -i '/"'""$uuid""'"$/a\,"'""$user""'"' /etc/trojan/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e "### $user $exp" >> /etc/trojan/akun.conf
systemctl restart trojan
trojanlink="trojan://${user}@${domain}:${tr}"
clear
echo -e "Succesfully Create ${RED}Trojan${NC} Accounts"
echo -e "Here Your Accounts Details :"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}IP Address${NC} : ${domain}"
echo -e "${GREEN}Remarks${NC} : ${user}"
echo -e "${GREEN}Port${NC} : ${tr}"
echo -e "${GREEN}Key${NC} : ${user}"
echo -e "${GREEN}Expired Date${NC} : $exp"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}Trojan Configuration Link${NC} : ${trojanlink}"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}Script By PakyaVPN${NC}"
echo -e "${GREEN}t.me/anakjati567${NC}"
echo -e "${RED}===================================================${NC}"
read -p "Press Enter For Back To Trojan Menu/ CTRL+C To Cancel : "
trojan-menu

