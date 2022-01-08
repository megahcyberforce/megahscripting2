#!/bin/bash
#SSH-Menu

clear
echo -e "V2Ray/VLess Menu" | lolcat
echo -e "1)Add V2Ray/VLess Accounts (addvless)"
echo -e "2)Delete V2Ray/VLess Accounts (delvless)"
echo -e "3)Check V2Ray/VLess Accounts Login (cekvless)"
echo -e "4)Renew V2Ray/VLess Accounts (renewvless)"
echo -e "5)Restart V2Ray/VLess TLS & NonTLS Services (restartvless)"
echo -e "6)Back To All Menu"
read -p "Please Choose An Option (1-6) : " menu
case $menu in
1)
addvless
exit
;;
2)
delvless
exit
;;
3)
cekvless
exit
;;
4)
renewvless
exit
;;
5)
systemctl restart v2ray@none
vless-menu
exit
;;
6)
menu
exit
;;
*)
echo "Please Input An Correct Number !"
;;
esac
