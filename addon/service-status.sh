#!/bin/bash
# Color
RED="\e[1;31m"
GREEN="\e[0;32m"
NC="\e[0m"

#servicesshow
fail2ban_service=$(/etc/init.d/fail2ban status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
dropbear_service=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
stunnel4_service=$(/etc/init.d/stunnel4 status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
squid_service=$(/etc/init.d/squid status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
v2ray_service=$(systemctl status v2ray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vless_service=$(systemctl status v2ray@none | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
trojan_service=$(systemctl status trojan | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx_service=$(/etc/init.d/nginx status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
xray_service=$(systemctl status xray-mini | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohp_service=$(systemctl status ohp-mini | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
trgo_service=$(systemctl status trgo-mini | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
openvpn_service=$(systemctl status openvpn | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
webmin_service=$(systemctl status webmin | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wg_service=$(systemctl status wg-quick@wg0 | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

if [[ $fail2ban_service == "running" ]]; then
   status_fail2ban="${GREEN}Fail2Ban Service Is Running ${NC}( No Eror )"
else
   status_fail2ban="${RED}Fail2Ban Service Is Not Running ${NC}( Eror ) "
fi

if [[ $ssh_service == "running" ]]; then 
   status_ssh="${GREEN}SSH Service Is Running ${NC}( No Eror )"
else
   status_ssh="${RED}SSH Service Is Not Running ${NC}( Eror )"
fi 

if [[ $dropbear_service == "running" ]]; then 
   status_dropbear="${GREEN}Dropbear Service Is Running ${NC}( No Eror )"
else
   status_dropbear="${RED}Dropbear Service Is Not Running ${NC}( Eror )"
fi 

if [[ $stunnel4_service == "running" ]]; then 
   status_stunnel4="${GREEN}Stunnel4 Service Is Running ${NC}( No Eror )"
else
   status_stunnel4="${RED}Stunnel4 Service Is Not Running ${NC}( Eror )"
fi 

if [[ $squid_service == "running" ]]; then 
   status_squid="${GREEN}Squid Service Is Running ${NC}( No Eror )"
else
   status_squid="${RED}Squid Service Is Not Running ${NC}( Eror )"
fi 

if [[ $v2ray_service == "running" ]]; then 
   status_v2ray="${GREEN}VMess [V2Ray] Service Is Running ${NC}( No Eror )"
else
   status_v2ray="${RED}VMess [V2Ray] Service Is Not Running ${NC}( Eror )"
fi 

if [[ $vless_service == "running" ]]; then 
   status_vless="${GREEN}VLess [V2Ray] Service Is Running ${NC}( No Eror )"
else
   status_vless="${RED}VLess [V2Ray] Service Is Not Running ${NC}( Eror )"
fi 

if [[ $trojan_service == "running" ]]; then 
   status_trojan="${GREEN}Trojan [V2Ray] Service Is Running ${NC}( No Eror )"
else
   status_trojan="${RED}Trojan [V2Ray] Service Is Not Running ${NC}( Eror )"
fi 

if [[ $xray_service == "running" ]]; then 
   status_xray="${GREEN}Xray Service Is Running ${NC}( No Eror )"
else
   status_xray="${RED}Xray Service Is Not Running ${NC}( Eror )"
fi

if [[ $ohp_service == "running" ]]; then 
   status_ohp="${GREEN}OHP Service Is Running ${NC}( No Eror )"
else
   service_ohp="${RED}OHP Service Is Not Running ${NC}( Eror )"
fi

if [[ $trgo_service == "running" ]]; then 
   status_trgo="${GREEN}Trojan-GO Service Is Running ${NC}( No Eror )"
else
   status_trgo="${RED}Trojan-GO Service Is Not Running ${NC}( Eror )"
fi 

if [[ $openvpn_service == "exited" ]]; then 
   status_openvpn="${GREEN}OpenVPN Service Is Running ${NC}( No Eror )"
else
   status_openvpn="${RED}OpenVPN Service Is Not Running ${NC}( Eror )"
fi 

if [[ $webmin_service == "running" ]]; then 
   status_webmin="${GREEN}Webmin Service Is Running ${NC}( No Eror )"
else
   status_webmin="${RED}Webmin Service Is Not Running ${NC}( Eror )"
fi 

if [[ $nginx_service == "running" ]]; then 
   status_nginx="${GREEN}Nginx Service Is Running ${NC}( No Eror )"
else
   status_nginx="${RED}Nginx Service Is Not Running ${NC}( Eror )"
fi 

if [[ $wg_service == "running" ]]; then 
   status_wg="${GREEN}Wireguard Service Is Running ${NC}( No Eror )"
else
   status_wg="${RED}Wireguard Service Is Not Running ${NC}( Eror )"
fi

echo -e "=====================================" | lolcat
echo -e "| Service Status Installed In VPS   |" | lolcat 
echo -e "=====================================" | lolcat
echo -e "
SSH         = $status_ssh
OpenVPN     = $status_openvpn
Dropbear    = $status_dropbear
STUNNEL4    = $status_stunnel4
Squid       = $status_squid
VMess       = $status_v2ray
VLess       = $status_vless
Trojan      = $status_trojan
TROJAN GO   = $status_trgo
Xray        = $status_xray
OHP         = $status_ohp
Wireguard   = $status_wg
Fail2Ban    = $status_fail2ban
Webmin      = $status_webmin
Nginx       = $status_nginx
"
echo -e "=====================================" | lolcat