#!/bin/sh

apt-get update

# update Golang
curl -fsSL https://go.dev/dl/go1.17.3.linux-amd64.tar.gz | tar -C /home -xzv

#安装rclone
cd /home/project/rclone/rclone-*-linux-amd64
cp rclone /usr/bin/
chown root:root /usr/bin/rclone
chmod 755 /usr/bin/rclone

#安装设置cron
apt-get install cron -y
env >> /etc/default/locale
touch /var/spool/cron/crontabs/root
echo "*/5 * * * * rclone sync /home/project/Code gdrive:okteto/Code --max-size 1M --transfers=1 --config /home/project/rclone/gd.conf >/dev/null 2>&1" >>/var/spool/cron/crontabs/root
chmod 600 /var/spool/cron/crontabs/root
service cron restart
