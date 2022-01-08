#!/bin/bash
# Trojan GO
# ===========================

# Downloading Core
wget -O /usr/bin/trgo-mini "https://raw.githubusercontent.com/wakleman/wakleman1/main/core/trojan-go"
chmod +x /usr/bin/trgo-mini

# DO NOT EDIT THIS ( START )
cat > /etc/systemd/system/trgo-mini.service << END
[Unit]
Description=Trojan-Go Mini
Documentation=https://pakyavpn.com https://github.com/p4gefau1t
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/trgo-mini -config /etc/trgo-mini/config.json
Restart=on-failure
RestartSec=10s
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
END
# DO NOT EDIT THIS ( END )

# Domain
domain=$(cat /etc/v2ray/domain)

# Configuration
mkdir -p /etc/trgo-mini/
mkdir -p /etc/trgo-mini/
mkdir -p /etc/trgo-mini/
mkdir -p /etc/trgo-mini/
cat > /etc/trgo-mini/config.json << END
{
  "run_type": "server",
  "local_addr": "0.0.0.0",
  "local_port": 446,
  "remote_addr": "127.0.0.1",
  "remote_port": 81,
  "password": [
        "ewioejoifjoiew0210weos"
  ],
  "disable_http_check": true,
  "udp_timeout": 60,
  "ssl": {
    "verify": false,
    "verify_hostname": false,
    "cert": "/etc/v2ray/v2ray.crt",
    "key": "/etc/v2ray/v2ray.key",
    "key_password": "",
    "cipher": "",
    "curves": "",
    "prefer_server_cipher": false,
    "sni": "$domain",
    "alpn": [
      "http/1.1"
    ],
    "session_ticket": true,
    "reuse_session": true,
    "plain_http_response": "",
    "fallback_addr": "127.0.0.1",
    "fallback_port": 0,
    "fingerprint": "firefox"
  },
  "tcp": {
    "no_delay": true,
    "keep_alive": true,
    "prefer_ipv4": true
  },
  "mux": {
    "enabled": false,
    "concurrency": 8,
    "idle_timeout": 60
  },
  "websocket": {
    "enabled": true,
    "path": "/trojan-go",
    "host": "$domain"
  },
    "api": {
    "enabled": false,
    "api_addr": "",
    "api_port": 0,
    "ssl": {
      "enabled": false,
      "key": "",
      "cert": "",
      "verify_client": false,
      "client_cert": []
    }
  }
}
END

# Starting Service
systemctl enable trgo-mini
systemctl start trgo-mini
systemctl restart trgo-mini

wget -q -O /usr/bin/addtrgo "https://raw.githubusercontent.com/wakleman/wakleman1/main/add/addtrgo.sh"
wget -q -O /usr/bin/deltrgo "https://raw.githubusercontent.com/wakleman/wakleman1/main/del/deltrgo.sh"
wget -q -O /usr/bin/renewtrgo "https://raw.githubusercontent.com/wakleman/wakleman1/main/renew/renewtrgo.sh"

chmod +x /usr/bin/addtrgo
chmod +x /usr/bin/deltrgo
chmod +x /usr/bin/renewtrgo
