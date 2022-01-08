#!/bin/bash
read -p "Input Your New Domain : " newdomain
        if [[ $newdomain == "" ]]; then
            echo "Please Input Domain"
            exit 1
        fi
echo "$newdomain" > /root/domain
echo "$newdomain" > /etc/v2ray/domain
cert
clear
echo "Successfull Changed To $newdomain"