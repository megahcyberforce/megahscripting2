#!/bin/bash
#SSH-Menu

# Color
clear 
echo -e "ShadowsocksR Menu" | lolcat 
echo -e "1) Add ShadowsocksR VPN Account (addssr)" | lolcat 
echo -e "2) Delete ShadowsocksR VPN Account (delssr)" | lolcat 
echo -e "3) Renew ShadowsocksR VPN Account (renewssr)" | lolcat 
echo -e "4) Restart ShadowsocksR Services" | lolcat 
echo -e "5) Back To All Menu" | lolcat 
read -p "Please Choose An Option (1-5) : " menu
case $menu in
1)
addssr
exit
;;
2)
delssr
exit
;;
3)
renewssr
exit
;;
4)
echo "Restarting All ShadowsocksR Services..."
systemctl restart xray-mini
clear 
echo "Succesfully Restart All SHadowsocksR Services"
sleep 0.5
ssr-menu
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