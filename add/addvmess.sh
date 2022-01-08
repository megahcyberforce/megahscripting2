#!/bin/bash
# Add Vmess
# ===================

# Color
RED="\e[1;31m"
GREEN="\e[0;64m"
NC="\e[0m"

ipadd=$(curl -s ipinfo.io/ip);

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

IP=$( curl -s ipinfo.io/ip );
clear
source /var/lib/pakyavpn/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$(cat /root/domain)
fi
tls=$(cat /etc/v2ray/config.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/       //g')
none=$(cat /etc/v2ray/none.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/       //g')

until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/v2ray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"64"',"email": "'""$user""'"' /etc/v2ray/config.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"64"',"email": "'""$user""'"' /etc/v2ray/none.json
cat>/etc/v2ray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "64",
      "net": "ws",
      "path": "/v2ray",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF
cat>/etc/v2ray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "64",
      "net": "ws",
      "path": "/v2ray",
      "type": "none",
      "host": "",
      "tls": "none"
}
EOF

# Make File For Clash
cp /etc/pakyavpn/clash-nontls.yaml /home/vps/public_html/clash/${user}-nontls.yaml

# Input Username to clash configuration
sed -i "s/pakyavpn1/$user/g" /home/vps/public_html/clash/${user}-nontls.yaml
sed -i "s/pakyavpn2/$domain/g" /home/vps/public_html/clash/${user}-nontls.yaml
sed -i "s/pakyavpn3/$none/g" /home/vps/public_html/clash/${user}-nontls.yaml
sed -i "s/pakyavpn4/vmess/g" /home/vps/public_html/clash/${user}-nontls.yaml
sed -i "s/pakyavpn5/$uuid/g" /home/vps/public_html/clash/${user}-nontls.yaml
sed -i "s/pakyavpn6/64/g" /home/vps/public_html/clash/${user}-nontls.yaml
sed -i "s/pakyavpn7/auto/g" /home/vps/public_html/clash/${user}-nontls.yaml
sed -i "s/pakyavpn8/$domain/g" /home/vps/public_html/clash/${user}-nontls.yaml

# Make File For Clash ( TLS )
cp /etc/pakyavpn/clash-tls.yaml /home/vps/public_html/clash/${user}-tls.yaml

# Input Username to clash configuration
sed -i "s/pakyavpn1/$user/g" /home/vps/public_html/clash/${user}-tls.yaml
sed -i "s/pakyavpn2/$domain/g" /home/vps/public_html/clash/${user}-tls.yaml
sed -i "s/pakyavpn3/$tls/g" /home/vps/public_html/clash/${user}-tls.yaml
sed -i "s/pakyavpn4/vmess/g" /home/vps/public_html/clash/${user}-tls.yaml
sed -i "s/pakyavpn5/$uuid/g" /home/vps/public_html/clash/${user}-tls.yaml
sed -i "s/pakyavpn6/64/g" /home/vps/public_html/clash/${user}-tls.yaml
sed -i "s/pakyavpn7/auto/g" /home/vps/public_html/clash/${user}-tls.yaml
sed -i "s/pakyavpn8/$domain/g" /home/vps/public_html/clash/${user}-tls.yaml


vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslink1="vmess://$(base64 -w 0 /etc/v2ray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /etc/v2ray/$user-none.json)"
systemctl restart v2ray
systemctl restart v2ray@none
service cron restart
clear
echo -e "Succesfully Create ${RED}V2Ray/VMess${NC} Accounts"
echo -e "Here Your Accounts Details :"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}IP Address${NC} : ${ipadd}"
echo -e "${GREEN}Remarks${NC} : ${user}"
echo -e "${GREEN}Port TLs${NC} : ${tls}"
echo -e "${GREEN}Port Non-TLs${NC} : ${none}"
echo -e "${GREEN}ID${NC} : ${uuid}"
echo -e "${GREEN}AlterID${NC} : 64"
echo -e "${GREEN}Network${NC} : ws"
echo -e "${GREEN}Security${NC} : auto"
echo -e "${GREEN}Path${NC} : /v2ray"
echo -e "${GREEN}Expired Date${NC} : $exp"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}V2Ray/VMess TLs Configuration Link${NC} : ${vmesslink1}"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}V2Ray/VMess Non-TLs Configuration Link${NC} : ${vmesslink2}"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}Yaml Config Link${NC}"
echo -e "${GREEN}Link Yaml TLS${NC} : http://${IP}:81/clash/${user}-tls.yaml"
echo -e "${GREEN}Link Yaml Non-TLS${NC} : http://${IP}:81/clash/${user}-nontls.yaml"
echo -e "${RED}===================================================${NC}"
echo -e "${GREEN}Script By PakyaVPN${NC}"
echo -e "${GREEN}t.me/anakjati567${NC}"
echo -e "${RED}===================================================${NC}"
read -p "Press Enter For Back To V2Ray/VMess Menu/ CTRL+C To Cancel : "
vmess-menu

