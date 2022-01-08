#!/bin/bash
# Auto Domain DNS & Wildcard
# ==============================

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

mkdir -p /etc/v2ray
touch /etc/v2ray/domain

# String
Domain_Hasil_Random=pakya.my.id

# IP Address
IP=$(curl -s ipinfo.io/ip);

# Random Sub Domain
SUB_DOMAIN="$(</dev/urandom tr -dc a-x1-9 | head -c7 | tr -d '\r')"

# Cloudflare Api Key 
EMAIL_CLOUDFLARE=fitrixxxshop@gmail.com
API_KEY_CLOUDFLARE=2e515cdc7e4fd5b796904e3702aec6b1f3a91

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# DNS Only Mode
ZonaPadaCloudflare=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${Domain_Hasil_Random}&status=active" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)
     
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZonaPadaCloudflare}/dns_records" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":0,"proxied":false}' | jq -r .result.id)

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZonaPadaCloudflare}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":0,"proxied":false}')
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# WildCard Mode
ZonaPadaCloudflare=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${Domain_Hasil_Random}&status=active" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)
     
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZonaPadaCloudflare}/dns_records" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'*.${SUB_DOMAIN}'","content":"'${IP}'","ttl":0,"proxied":false}' | jq -r .result.id)

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZonaPadaCloudflare}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'*.${SUB_DOMAIN}'","content":"'${IP}'","ttl":0,"proxied":false}')
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Input To VPS
echo "$SUB_DOMAIN.$Domain_Hasil_Random" > /root/domain
echo "$SUB_DOMAIN.$Domain_Hasil_Random" > /etc/v2ray/domain
echo "$IP" > /var/lib/premium-script/ipvps.conf



