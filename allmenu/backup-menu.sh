#!/bin/bash
#SSH-Menu

clear
echo -e "Backup Menu" | lolcat
echo -e "1) Setup Auto Backup (autobackup)" | lolcat
echo -e "2) Backup Data (backup)" | lolcat
echo -e "3) Restore Data (restore)" | lolcat
echo -e "4) Back To All Menu" | lolcat
read -p "Please Choose An Option (1-5) : " menu
case $menu in
1)
autobackup
exit
;;
2)
backup
exit
;;
3)
restore
exit
;;
4)
menu
exit
;;
*)
echo "Please Input An Correct Number !"
;;
esac
