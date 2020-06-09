# f1-micro-basic-config
A small script that auto-configures Google cloud's "f1-micro" machines to preform optimaly as a static website host 
<h4>Prerequisites</h4>
- an f1-micro instance with ubuntu-20.04 and git<br>
-a registered domain name
<h2>What does it do?</h2>
<ul>
  <li>Adds a small swapfile</li>
  <li>Installs and configures apache2 server for optimal performance</li>
  <li>Installs LIQUORIX Custom Kernal and Zram (since the server instance would have to deal with a lot of swaping and I/O operations due to the lack of RAM)</li>
  <li>Installs and configures ufw</li>
  </ul>
   
  <strong>To keep the custom kernal up to date, the server would have to have around 20:30 seconds of downtime everyday at 12AM after an update&restart cron-job</strong>
 <hr>
  <h3>TODO</h3>
  -Add a clamav script && a clamav cron-job
