#!/bin/bash
#SSH-Menu

clear 
echo -e "Trojan-GFW Menu" | lolcat
echo -e "1) Add TRojan-GFW Accounts (addtrojan)" | lolcat
echo -e "2) Delete TRojan-GFW Accounts (deltrojan)" | lolcat
echo -e "3) Check TRojan-GFW Accounts Login (cektrojan)" | lolcat
echo -e "4) Renew TRojan-GFW Accounts (renewtrojan)" | lolcat
echo -e "5) Restart TRojan-GFW Services (restarttrojan)" | lolcat
echo -e "6) Back To All Menu" | lolcat
read -p "Please Choose An Option (1-6) : " menu
case $menu in
1)
addtrojan
exit
;;
2)
deltrojan
exit
;;
3)
cektrojan
exit
;;
4)
renewtrojan
exit
;;
5)
systemctl restart trojan
trojan-menu
;;
6)
menu 
;;
*)
echo "Please Input An Correct Number !"
;;
esac
