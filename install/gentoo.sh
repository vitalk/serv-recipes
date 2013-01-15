#!/usr/bin/env bash
# Performs a complete installation of new nginx site for gentoo server
# Usage: curl https://raw.github.com/vitalk/serv-recipes/master/install/gentoo.sh | my_app=app my_domain=app.example.com sh

wget https://raw.github.com/vitalk/serv-recipes/master/nginx/app -O /etc/nginx/sites-available/$my_app
ln -sf /etc/nginx/sites-{available,enabled}/$my_app

sed -i "s/YOUR_APP_NAME/$my_app/" /etc/nginx/sites-available/$my_app
sed -i 's/YOUR_SERVER_IP:80/80/' /etc/nginx/sites-available/$my_app
sed -i "s/YOUR_SERVER_FQDN/$my_domain/" /etc/nginx/sites-available/$my_app
