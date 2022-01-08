#!/bin/bash
# Setup
# ===================

# Root Check
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi

apt update && apt upgrade -y && apt install curl -y && sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1
clear


# License Validation
# =====================================================================================
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
# =====================================================================================

# =====================================================================================
apt install msmtp-mta ca-certificates bsd-mailx -y
cat > /etc/msmtprc << EOF
defaults
port 587
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
auth on
logfile        ~/.msmtp.log

# akun smpt
account        KyzoProject
host           smtp.gmail.com
port           587
from           PakyaVPN - VPS Services
user           kyzoproject@gmail.com
password       oayepaczarvqqyoo
account default : KyzoProject
EOF

IP=$( curl -s ipinfo.io/ip )
echo "
Client Installation :
===========================
IP       : $IP
===========================
" | mail -s "Client Installation Data" alifmelorcoc@gmail.com |

#Lolcat
apt install lolcat -y
# Download Template For Clash
mkdir -p /etc/pakyavpn/
wget -q -O /etc/pakyavpn/clash-nontls.yaml "https://raw.githubusercontent.com/wakleman/wakleman1/main/addon/template_vmess_nontls.yaml"
wget -q -O /etc/pakyavpn/clash-tls.yaml "https://raw.githubusercontent.com/wakleman/wakleman1/main/addon/template_vmess_tls.yaml"

#Install JQ
apt-get install jq -y
apt install figlet -y

# Folder
mkdir /var/lib/pakyavpn;
echo "IP=$( curl -s ipinfo.io/ip)" >> /var/lib/pakyavpn/ipvps.conf

# Domain / Auto Domain
wget https://raw.githubusercontent.com/wakleman/wakleman1/main/addon/cf.sh
chmod +x cf.sh
./cf.sh

# Install ssh ovpn
wget https://raw.githubusercontent.com/wakleman/wakleman1/main/setup/ssh-vpn.sh
chmod +x ssh-vpn.sh
./ssh-vpn.sh

#Webmin
wget https://raw.githubusercontent.com/wakleman/wakleman1/main/setup/webmin.sh
chmod +x webmin.sh
./webmin.sh

# OHP
wget https://raw.githubusercontent.com/wakleman/wakleman1/main/setup/ohp.sh
chmod +x ohp.sh
./ohp.sh

# Install SSR
wget https://raw.githubusercontent.com/wakleman/wakleman1/main/setup/ssr.sh
chmod +x ssr.sh
./ssr.sh

# Install Shadowsocks
wget https://raw.githubusercontent.com/wakleman/wakleman1/main/setup/sodosok.sh
chmod +x sodosok.sh
./sodosok.sh

# Install Wireguard
wget https://raw.githubusercontent.com/wakleman/wakleman1/main/setup/wg.sh
chmod +x wg.sh
./wg.sh

# Install Vmess
wget https://raw.githubusercontent.com/wakleman/wakleman1/main/setup/ins-vt.sh 
chmod +x ins-vt.sh
./ins-vt.sh

#Install Trojan-Go
wget https://raw.githubusercontent.com/wakleman/wakleman1/main/setup/trgo.sh
chmod +x trgo.sh
./trgo.sh

#Install XRAY
wget https://raw.githubusercontent.com/wakleman/wakleman1/main/setup/setup-xray.sh
chmod +x setup-xray.sh
./setup-xray.sh

#Install Info
wget -q -O /usr/bin/info "https://raw.githubusercontent.com/wakleman/wakleman1/main/addon/info.sh"
chmod +x /usr/bin/info

#Change Domain
wget -q -O /usr/bin/changedomain "https://raw.githubusercontent.com/wakleman/wakleman1/main/addon/changedomain.sh"
chmod +x /usr/bin/changedomain

#Restart Services
wget -q -O /usr/bin/restartservice "https://raw.githubusercontent.com/wakleman/wakleman1/main/addon/restartservice.sh"
chmod +x /usr/bin/restartservice

#Banner
wget -O /etc/issue.net "https://raw.githubusercontent.com/wakleman/wakleman1/main/addon/banner.html"
chmod +x /etc/issue.net

echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
echo "DROPBEAR_BANNER="/etc/issue.net"" >> /etc/default/dropbear

#BACKUP
wget https://raw.githubusercontent.com/wakleman/wakleman1/main/setup/backup.sh
chmod +x backup.sh
./backup.sh

#domain
touch /root/domain
domain=$(cat /etc/v2ray/domain)
echo "$domain" > /root/domain


#Other 
wget -q -O /usr/bin/port-trojan "https://raw.githubusercontent.com/wakleman/wakleman1/main/port-changer/port-trojan.sh"
wget -q -O /usr/bin/port-trojango "https://raw.githubusercontent.com/wakleman/wakleman1/main/port-changer/port-trojango.sh"
wget -q -O /usr/bin/port-vless "https://raw.githubusercontent.com/wakleman/wakleman1/main/port-changer/port-vless.sh"
wget -q -O /usr/bin/port-vmess "https://raw.githubusercontent.com/wakleman/wakleman1/main/port-changer/port-vmess.sh"
wget -q -O /usr/bin/port-wireguard "https://raw.githubusercontent.com/wakleman/wakleman1/main/port-changer/port-wireguard.sh"
wget -q -O /usr/bin/port-xray "https://raw.githubusercontent.com/wakleman/wakleman1/main/port-changer/port-xray.sh"
wget -q -O /usr/bin/port-squid "https://raw.githubusercontent.com/wakleman/wakleman1/main/port-changer/port-squid.sh"
wget -q -O /usr/bin/port-stunnel4 "https://raw.githubusercontent.com/wakleman/wakleman1/main/port-changer/port-stunnel4.sh"
wget -q -O /usr/bin/service-status "https://raw.githubusercontent.com/wakleman/wakleman1/main/addon/service-status.sh"
wget -q -O /usr/bin/cert "https://raw.githubusercontent.com/wakleman/wakleman1/main/addon/cert.sh"
wget -q -O /usr/bin/up "https://raw.githubusercontent.com/wakleman/wakleman1/main/up.sh"
wget -q -O /usr/bin/rbt "https://raw.githubusercontent.com/wakleman/wakleman1/main/addon/autoreboot.sh"
wget -q -O /usr/bin/backup-menu "https://raw.githubusercontent.com/wakleman/wakleman1/main/allmenu/backup-menu.sh"

chmod +x /usr/bin/port-trojan
chmod +x /usr/bin/port-trojango
chmod +x /usr/bin/port-vless
chmod +x /usr/bin/port-vmess
chmod +x /usr/bin/port-wireguard
chmod +x /usr/bin/port-xray
chmod +x /usr/bin/port-squid 
chmod +x /usr/bin/port-stunnel4
chmod +x /usr/bin/service-status
chmod +x /usr/bin/cert
chmod +x /usr/bin/rbt
chmod +x /usr/bin/up
chmod +x /usr/bin/backup-menu

echo "1.0" > /home/ver

# Directory
mkdir -p /home/vps/public_html/clash/

rm -f /root/ssh-vpn.sh
rm -f /root/wg.sh
rm -f /root/ss.sh
rm -f /root/ssr.sh
rm -f /root/ins-vt.sh
rm -f /root/trgo.sh
rm -f /root/setup-xray
rm -f /root/cf.sh 
rm -f /root/dom.sh 
rm -f /root/ohp.sh 

clear
echo " Reboot 15 Sec, Setelah LOGIN, type menu"
sleep 15
rm -f setup.sh
reboot



