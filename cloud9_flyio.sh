#!/bin/sh
apt-get update
# 安装 CF CLI
curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx
mv cf /usr/local/bin
sudo curl -o /usr/share/bash-completion/completions/cf https://raw.githubusercontent.com/cloudfoundry/cli/master/ci/installers/completion/cf
# 安装 IBM Cloud CLI
curl -sL https://ibm.biz/idt-installer | bash
#安装 Okteto CLI
curl https://get.okteto.com -sSfL
#安装Flyio CLI
curl -L https://fly.io/install.sh | FLYCTL_INSTALL=/usr/local sh

# GD备份回来
output=`rclone copy gdrive:mycloud9 /c9ws/ --config /etc/c9conf/gd.conf`
#设置crontab
env >> /etc/default/locale
touch /var/spool/cron/crontabs/root
echo "*/10 * * * * /bin/sh /c9ws/rclone/sync.sh >/dev/null 2>&1" >>/var/spool/cron/crontabs/root
chmod 600 /var/spool/cron/crontabs/root
service cron restart
