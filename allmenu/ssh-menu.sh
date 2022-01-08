#!/bin/bash
#SSH-Menu

# Color
RED="\e[1;31m"
GREEN="\e[0;32m"
NC="\e[0m"
clear 
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "OPenVPN & SSH Menu" ; tput sgr0
echo -e "${RED}1)${NC} ${GREEN}Add SSH / OpenVPN Account (addssh)${NC}"
echo -e "${RED}2)${NC} ${GREEN}Create Trial SSH/OpenVPN Account (trialssh)${NC}"
echo -e "${RED}3)${NC} ${GREEN}Renew SSH / OpenVPN Account (renewssh)${NC}"
echo -e "${RED}4)${NC} ${GREEN}Delete SSH/OPenvpn Accounts (delssh)${NC}"
echo -e "${RED}5)${NC} ${GREEN}Check SSH/OPenvpn Account Login (cekssh)${NC}"
echo -e "${RED}6)${NC} ${GREEN}Clean All SSH/OPenvpn Accounts (sshexpclean)${NC}"
echo -e "${RED}7)${NC} ${GREEN}Restart All SSH & OPenVPN Services${NC}"
echo -e "${RED}8)${NC} ${GREEN}Back To All Menu${NC}"
read -p "Please Choose An Option (1-7) : " menu
case $menu in  
1)
addssh
exit
;;
2)
trialssh
exit
;;
3)
renewssh
exit
;;
4)
delssh
exit
;;
5)
cekssh
exit
;;
6)
sshexpclean
exit
;;
7)
echo "Restarting All SSH & OPenVPN Services..."
systemctl restart squid
systemctl restart dropbear
systemctl restart ssh 
systemctl restart stunnel4
systemctl restart ohp-mini
systemctl restart openvpn
systemctl restart openvpn-server@server-tcp-1194
systemctl restart openvpn-server@server-udp-2200
clear
echo "Succesfully Restart ALL SSH & OPenVPN Services !"
sleep 0.5
ssh-menu
;;
8)
menu
;;
*)
echo "Please Input An Correct Number !"
;;
esac