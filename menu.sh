#!/bin/bash
clear
IPVPS=$(curl -s ipinfo.io/ip )
echo ""
figlet PakyaVPN | lolcat
figlet AutoScript | lolcat
echo -e "OS : $( cat /etc/os-release | grep  PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' )" | lolcat
echo -e "Uptime : $(neofetch | grep Uptime | cut -d " " -f 2-100)" | lolcat
echo -e "Proccessor : $(neofetch | grep CPU | cut -d " " -f 2-100)" | lolcat
echo -e "Total Ram : $ram MB " | lolcat
echo -e "ISP / Provider : $(curl -s ipinfo.io/org)" | lolcat 
echo -e "Domain : $(cat /root/domain)" | lolcat
echo -e "IP Address : $(wget -qO- icanhazip.com)" | lolcat
echo ""
echo -e "===============================================================" | lolcat
echo -e "*                       Pakya AutoScriptVPN" | lolcat
echo -e  "  ╔═════════════════════════════════════════════════════════════════╗" | lolcat
echo -e  "  ║                          ┃ MAIN MENU ┃                          ║" |lolcat
echo -e  "  ╠═════════════════════════════════════════════════════════════════╝" | lolcat
echo -e  "  ║"
echo -e  "  ║   [1]   -> ->         [SSH & OpenVPN" | lolcat
echo -e  "  ║   [2]   -> ->         [Panel Wireguard" | lolcat
echo -e  "  ║   [3]   -> ->         [Panel SSR" | lolcat
echo -e  "  ║   [4]   -> ->         [Panel SS" | lolcat
echo -e  "  ║   [5]   -> ->         [Panel VMESS" | lolcat
echo -e  "  ║   [6]   -> ->         [Panel VLESS" | lolcat
echo -e  "  ║   [7]   -> ->         [Panel XRAY" | lolcat
echo -e  "  ║   [8]   -> ->         [Panel TROJAN" | lolcat
echo -e  "  ║ "
echo -e  "  ╠═════════════════════════════════════════════════════════════════╗" | lolcat
echo -e  "  ║                           ┃ SYSTEM  ┃                           ║" | lolcat
echo -e  "  ╠═════════════════════════════════════════════════════════════════╝" | lolcat
echo -e  "  ║"
echo -e  "  ║      [9] Panel Backup" | lolcat
echo -e  "  ║      [ 10] Add Or Change Subdomain Host For VPS" | lolcat
echo -e  "  ║      [ 12 ] Change Port Of Some Service" | lolcat
echo -e  "  ║      [ 13 ] Reboot VPS" | lolcat
echo -e  "  ║      [ 14 ] Auto Reboot Menu" | lolcat
echo -e  "  ║      [ 15 ] Speedtest VPS" | lolcat
echo -e  "  ║      [ 16 ] Update Script To Latest Version" | lolcat
echo -e  "  ║"
echo -e  "  ╠═════════════════════════════════════════════════════════════════╗" | lolcat
echo -e  "  ║      [x] Exit Menu                                              ║" | lolcat
echo -e  "  ╚═════════════════════════════════════════════════════════════════╝" | lolcat
echo -e ""
read -p "             Select From Options [1-16 or x]: " menu 
echo -e ""
case $menu in
1)
ssh-menu
exit
;;
2)
wg-menu
exit
;;
3)
ssr-menu
exit
;;
4)
ss-menu
exit
;;
5)
vmess-menu
exit
;;
6)
vless-menu
exit
;;
7)
xray-menu
exit
;;
8)
trojan-menu
exit
;;
9)
backup-panel
exit
;;
10)
changedomain
exit
;;
11)
port-menu
exit
;;
12)
reboot
;;
13)
rbt
;;
14)
speedtest
;;
15)
up
;;
x)
exit
menu
;;
*)
echo " Please enter an correct number!!"
;;
esac