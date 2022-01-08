#!/bin/bash
#SSH-Menu

clear
echo -e "Wireguard Menu" | lolcat 
echo -e "1) Add Wireguard Account (addwg)" | lolcat 
echo -e "2) Delete Wireguard Account (delwg)" | lolcat 
echo -e "3) Renew Wireguard Account (renewwg)" | lolcat 
echo -e "4) Restart Wireguard Services" | lolcat 
echo -e "5) Back To All Menu" | lolcat 
read -p "Please Choose An Option (1-5) : " menu
case $menu in
1)
addwg
exit
;;
2)
delwg
exit
;;
3)
renewwg
exit
;;
4)
systemctl restart wg-quick@wg0
wg-menu
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
