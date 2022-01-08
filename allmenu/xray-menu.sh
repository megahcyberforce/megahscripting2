#!/bin/bash
#SSH-Menu

clear
echo -e "VLess/Xray Menu" | lolcat
echo -e "1) Add Vless Xray Account (addxray)" | lolcat
echo -e "2) Delete Vless Xray Account (delxray)" | lolcat
echo -e "3) Renew Vless Xray Account (renewxray)" | lolcat
echo -e "4) Restart VLess XRay Services" | lolcat
echo -e "5) Back To All Menu" | lolcat
read -p "Please Choose An Option (1-5) : " menu
case $menu in
1)
addxray
exit
;;
2)
delxray
exit
;;
3)
renewxray
exit
;;
4)
systemctl restart xray-mini
xray-menu
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
