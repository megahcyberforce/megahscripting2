#!/bin/bash
curl https://rclone.org/install.sh | bash
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/wakleman/wakleman1/main/addon/rclone.conf"
git clone  https://github.com/magnific0/wondershaper.git
cd wondershaper
make install
cd
rm -rf wondershaper
echo > /home/limit
cd /usr/bin
wget -O autobackup "https://raw.githubusercontent.com/wakleman/wakleman1/main/backup/autobackup.sh"
wget -O backup "https://raw.githubusercontent.com/wakleman/wakleman1/main/backup/backup.sh"
wget -O bckp "https://raw.githubusercontent.com/wakleman/wakleman1/main/backup/bckp.sh"
wget -O restore "https://raw.githubusercontent.com/wakleman/wakleman1/main/backup/restore.sh"
chmod +x autobackup
chmod +x backup
chmod +x bckp
chmod +x restore
cd
rm -f /root/backup.sh

