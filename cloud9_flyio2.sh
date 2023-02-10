#!/bin/sh
apt-get update
#安装 Okteto CLI
curl https://get.okteto.com -sSfL | sh
#安装Flyio CLI
curl -L https://fly.io/install.sh | FLYCTL_INSTALL="/root/.fly" | PATH="$FLYCTL_INSTALL/bin:$PATH" sh

npm i -g vercel
