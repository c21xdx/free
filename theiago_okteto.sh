#!/bin/sh

apt-get update

# update Golang
curl -fsSL https://go.dev/dl/go1.17.3.linux-amd64.tar.gz | tar -C /home -xzv

#rclone
cd /home/project/rclone/rclone-*-linux-amd64
cp rclone /usr/bin/
chown root:root /usr/bin/rclone
chmod 755 /usr/bin/rclone
