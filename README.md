# f1-micro-basic-config
A small script that auto-configures Google cloud's "f1-micro" machines to preform optimaly as a static website host 
<h4>Prerequisites</h4>
- an f1-micro instance with ubuntu-20.04 and git<br>
-a registered domain name

<h4>Technical information:</h4>
<br><br>
<code>Adds a small swapfile(800M) and configures /etc/fstab</code><br><br>
<code>Installs LAMP stack, configures apache2 server and disables mysql for optimal performance</code> <br><br>
<code>Adds Apache read premissions to '/home/' </code><br><br>
<code>Installs LIQUORIX Custom Kernal and Zram (since the server instance would have to deal with a lot of swaping and I/O operations due to the lack of RAM)</code><br><br>
<code>Installs and configures ufw(opens ports for openssh, Apache, SFTP and SSL)</code>
<br><br>
<code>Installs fail2ban and applies the default configs</code><br><br>
<strong>To keep the custom kernal up to date, the server would have to have around 20:30 seconds of downtime everyday at 12AM after an update&restart cron-job</strong>
  <h3>TODO</h3>
