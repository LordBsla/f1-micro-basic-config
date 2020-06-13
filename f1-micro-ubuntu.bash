#!/bin/bash 
sudo su root
cd /
apt update
apt upgrade -y
#settign up swap
fallocate -l 800M /swapfile
dd if=/dev/zero of=/swapfile bs=1024 count=781250
mkswap /swapfile
chmod 600 /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >>  /etc/fstab
#To make sure the custom kernal is always up to date the system reboots daily @ 12AM(around 20:30 seconds of downtime)
echo "@daily systemctl reboot" >> /var/spool/cron/crontabs/root
echo "@hourly apt update && apt upgrade -y" >> /var/spool/cron/crontabs/root
#packages0
sleep 1
apt install cron software-properties-common wget git php-curl php-gd php-mbstring php-xml php-xmlrpc tmux vsftpd net-tools ufw zram -y
#Custom Kernal - Live patch won't work so a server restart every once in a while would be neccesarry
add-apt-repository ppa:damentz/liquorix && apt-get update
sleep 1
apt-get install linux-image-liquorix-amd64 linux-headers-liquorix-amd64 -y
#Installing the lampstack
tasksel install lamp-server
sleep 1
systemctl disable mysql
countdown(){
for (( i=0; i<=10; i=i+2 ))
do  
   sleep .5
   printf "Lamp stack got installed,but mysql is disabled\nIf you're hosting a non-static website, it'll do you good to run:...\nsystemctl enable mysql\n"
   echo $i
   sleep 1.5
   clear
done

}
countdown
#apache2 memory optimization(will overwrite the mpm_prefork.conf)
printf "# prefork MPM\n# StartServers: number of server processes to start\n# MinSpareServers: minimum number of server processes which are kept spare\n# MaxSpareServers: maximum number of server processes which are kept spare\n# MaxRequestWorkers: maximum number of server processes allowed to start\n# MaxConnectionsPerChild: maximum number of requests a server process serves\n<IfModule mpm_prefork_module>\n        StartServers                     1\n        MinSpareServers           2\n        MaxSpareServers          4\n        MaxRequestWorkers         40\n        MaxConnectionsPerChild   200\n</IfModule>\n\n# vim: syntax=apache ts=4 sw=4 sts=4 sr noet" > /etc/apache2/mods-enabled/mpm_prefork.conf
# you can also do:
#apt-get install lamp-server^
ufw allow OpenSSH
ufw allow 22/tcp
ufw allow Apache
ufw enable
printf "<Directory /home/abdo/>\n        Options Indexes FollowSymLinks\n        AllowOverride None\n        Require all granted\n</Directory>
" >> /etc/apache2/apache2.conf
#---------------
#you might wanna put your website in /home/$user/example.com so you can edit the website via SFTP without needing root premissions
#'a2ensite' is used to load an Apache config from /etc/apche2/sites-available while 'a2dissite' is used to disable them
#Always reload apache so that changes could take place
#to make sure you did setup the dns 'A' records, you can ping the domain name and see if the command 'ping' points to your server's external ip adress to make sure it's working correctly
#UFW's Bitch (3 hours of mylife never coming back)

