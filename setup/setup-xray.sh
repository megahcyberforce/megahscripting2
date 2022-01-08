#!/bin/bash
# ===================================
# Xray Quick Setup
# Auther : pakyavpn
# ===================================

# // Silakan Isi Bawah Ini
export port='443' # >> Port Vless RPRX Direct
export Cert_path='/etc/v2ray/v2ray.crt' # >> Certificate Path
export Cert_Key_Path='/etc/v2ray/v2ray.key' # >> Certificate Key Path
export Your_Domain='pakyavpn.xyz' # >> Your Domain

# // Creating UUID
export uuid=$(cat /proc/sys/kernel/random/uuid)

# // Installing Requirement
apt update -y
apt upgrade  -y
apt install zip unzip gzip curl wget nano vim -y

# // Downloading Core
wget -O /usr/local/xray-mini "https://raw.githubusercontent.com/wakleman/wakleman1/main/core/xray-mini"
chmod +x /usr/local/xray-mini

# // Make Config Folder
mkdir -p /etc/xray-mini/

# // Installing Service
cat > /etc/systemd/system/xray-mini.service << END
[Unit]
Description=XRay-Mini 
Documentation=https://kdev.my.id
After=syslog.target network-online.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/xray-mini -c /etc/xray-mini/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END

# // XRay XTLS RPRX Direct
cat > /etc/xray-mini/config.json << END
{
  "inbounds": [
    {
      "port": ${port},
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "flow": "xtls-rprx-direct"
#XRay
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 60000,
            "alpn": "",
            "xver": 1
          },
          {
            "dest": 60001,
            "alpn": "h2",
            "xver": 1
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "minVersion": "1.2",
          "certificates": [
            {
              "certificateFile": "${Cert_path}",
              "keyFile": "${Cert_Key_Path}"
            }
          ]
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
END

systemctl disable xray-mini
systemctl stop xray-mini
systemctl enable xray-mini
systemctl start xray-mini

cd /usr/bin

#Add & Del 
wget -O addxray "https://raw.githubusercontent.com/wakleman/wakleman1/main/add/addxray.sh"
wget -O delxray "https://raw.githubusercontent.com/wakleman/wakleman1/main/del/delxray.sh"
wget -O renewxray "https://raw.githubusercontent.com/wakleman/wakleman1/main/renew/renewxray.sh"

chmod +x addxray
chmod +x delxray
chmod +x renewxray
cd
rm -f setup-xray.sh
