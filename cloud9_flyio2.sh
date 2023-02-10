#!/bin/sh
apt-get update
#安装 Okteto CLI
curl https://get.okteto.com -sSfL | sh
#安装Flyio CLI
curl -L https://fly.io/install.sh | sh
export FLYCTL_INSTALL="/root/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

#设置crontab
env >> /etc/default/locale
touch /var/spool/cron/crontabs/root
echo "*/10 * * * * /bin/sh /c9ws/rclone/sync.sh >/dev/null 2>&1" >>/var/spool/cron/crontabs/root
chmod 600 /var/spool/cron/crontabs/root
service cron restart
