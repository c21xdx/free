#!/bin/sh

# GD拷回
output=`rclone copy gdrive:mycloud9 /c9ws/ --config /etc/c9conf/gd.conf`
#设置crontab
env >> /etc/default/locale
touch /var/spool/cron/crontabs/root
echo "*/10 * * * * /bin/sh /c9ws/rclone/sync.sh >/dev/null 2>&1" >>/var/spool/cron/crontabs/root
service cron restart
