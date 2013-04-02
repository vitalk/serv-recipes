#!/usr/bin/env bash
# Performs a installation of new app behind nginx proxy
# Usage: curl https://raw.github.com/vitalk/serv-recipes/master/install/nginx-proxy-pass.sh | my_proxy_pass=127.0.0.1:6543 my_fqdn=app.example.com bash

mkdir -p /etc/nginx/sites-{available,enabled}
wget https://raw.github.com/vitalk/serv-recipes/master/nginx/proxy-pass -O /etc/nginx/sites-available/$my_fqdn
ln -s /etc/nginx/sites-{available,enabled}/$my_fqdn

sed -i 's/YOUR_SERVER_IP:80/80/' /etc/nginx/sites-available/$my_fqdn
sed -i "s/YOUR_SERVER_FQDN/$my_fqdn/" /etc/nginx/sites-available/$my_fqdn
sed -i "s/YOUR_PROXY_PASS/$my_proxy_pass/" /etc/nginx/sites-available/$my_fqdn
