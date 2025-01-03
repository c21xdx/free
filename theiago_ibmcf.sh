#!/bin/sh
apt-get update

# update Golang
curl -fsSL https://go.dev/dl/go1.17.3.linux-amd64.tar.gz | tar -C /home -xzv

# GD备份回来
output=`rclone copy gdrive:theiaide/GoCode /home/project/GoCode --config /etc/goconf/gd.conf`

#设置crontab
env >> /etc/default/locale
touch /var/spool/cron/crontabs/root
echo "*/5 * * * * rclone sync /home/project/GoCode gdrive:theiaide/GoCode --max-size 1M --transfers=1 --config /etc/goconf/gd.conf >/dev/null 2>&1" >>/var/spool/cron/crontabs/root
chmod 600 /var/spool/cron/crontabs/root
service cron restart
