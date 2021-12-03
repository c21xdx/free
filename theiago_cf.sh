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

#安装设置cloudflared
mkdir /home/project/cf
cd /home/project/cf
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
dpkg -i cloudflared-linux-amd64.deb
rm -rf /home/project/cf/cloudflared-linux-amd64.deb
mkdir -p ~/.cloudflared/
touch ~/.cloudflared/cert.pem
echo "${{ secrets.CFTUNNEL_CERT }}" >>~/.cloudflared/cert.pem
nohup cloudflared tunnel --${{ secrets.CF_DOMAIN }} --url localhost:${{ secrets.CF_PORT }} &
