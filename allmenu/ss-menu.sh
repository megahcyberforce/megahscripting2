#!/bin/bash
#SSH-Menu

# Color
clear 
echo -e "Shadowsocks Menu" | lolcat
echo -e "1) Add Shadowsocks VPN Account (addss)" | lolcat
echo -e "2) Delete Shadowsocks VPN Account (delss)" | lolcat
echo -e "3) Checking Shadowsocks Client Login (cekss)" | lolcat
echo -e "4) Renew Shadowsocks VPN Account (renewss)" | lolcat
echo -e "5) Restart SHadowsocks Services" | lolcat
echo -e "6) Back To All Menu" | lolcat
read -p "Please Choose An Option (1-6) : " menu
case $menu in  
1)
addss
exit
;;
2)
delss
exit
;;
3)
cekss
exit
;;
4)
renewss
exit
;;
5)
echo "Restarting All Shadowsocks Services..."
systemctl restart shadowsocks-libev
clear 
echo "Succesfully Restart All Shadowsocks Services"
sleep 0.5
ss-menu
exit
;;
5)
menu
exit
;;
*)
echo "Please Input An Correct Number !"
;;
esac