#!/bin/bash
#SSH-Menu

clear
echo -e "V2Ray/VMess Menu" | lolcat
echo -e "1) Add V2Ray/VMess Accounts (addvmess)" | lolcat
echo -e "2) Delete V2Ray/VMess Accounts (delvmess)" | lolcat
echo -e "3) Check V2Ray/VMess Accounts Login (cekvmess)" | lolcat
echo -e "4) Renew V2Ray/VMess Accounts (renewvmess)" | lolcat
echo -e "5) Restart V2Ray/VMess TLS & NonTLS Services (restartvmess)" | lolcat
echo -e "6) Back To All Menu" | lolcat
read -p "Please Choose An Option (1-6) : " menu
case $menu in
1)
addvmess
exit
;;
2)
delvmess
exit
;;
3)
cekvmess
exit
;;
4)
renewvmess
exit
;;
5)
systemctl restart v2ray
vmess-menu
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
