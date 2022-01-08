#!/bin/bash
#SSH-Menu

# Color
clear 
echo -e "Port Changer Menu" | lolcat
echo -e "1)Change Port [V2Ray] Trojan (port-trojan)" | lolcat
echo -e "2)Change Port [V2Ray] Vmess (port-vmess)" | lolcat
echo -e "3)Change Port [V2Ray] Vless (port-vless)" | lolcat
echo -e "4)Change Port [Xray] Vless (port-xray)" | lolcat
echo -e "5)Change Port Squid (port-squid)" | lolcat
echo -e "6)Change Port Stunnel4 (port-stunnel4)" | lolcat
echo -e "7)Back To All Menu" | lolcat
read -p "Please Choose An Option (1-5) : " menu 
case $menu in
1)
port-trojan
exit
;;
2)
port-vmess
exit
;;
3)
port-vless
exit
;;
4)
port-xray
exit
;;
5)
port-squid
exit
;;
6)
port-stunnel4
exit
;;
7)
menu
exit
;;
*)
echo "Please Input An Correct Number !"
;;
esac