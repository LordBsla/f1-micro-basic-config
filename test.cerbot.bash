#!/bin/bash
sudo su root

apt install certbot python3-certbot-apache
sleep 1 && clear
echo "Please enter your domain name"
read domain
certbot --apache -d $domain
#Temp
