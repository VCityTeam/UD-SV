# Apache web server quick install notes

In the context of [UD-SV](..), a [web server](https://en.wikipedia.org/wiki/Web_server) is needed e.g. to handle over
 * 3DTiles tilesets
 * UD-Viz-core and its associated demos
 * ...

A quick installation of an [Apache http server](https://en.wikipedia.org/wiki/Apache_HTTP_Server) goes
```
  sudo apt install apache2
  sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/rict.liris.cnrs.fr.conf
```
Edit the newly copied configuration file `/etc/apache2/sites-available/rict.liris.cnrs.fr.conf`: the following ad-hoc configuration should make it
```
<VirtualHost *:80>
	ServerName rict.liris.cnrs.fr
	ServerAlias www.rict.liris.cnrs.fr
	ServerAdmin webmaster@localhost
	DocumentRoot /home/citydb_user/Vilo3d
  <Directory /home/citydb_user/Vilo3d>
     Options Indexes FollowSymLinks MultiViews
     AllowOverride all
     Require all granted
  </Directory>
  ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
In case of [CORS](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) related errors refer to [Getting CORS to work with Apache](https://awesometoast.com/cors/) for further twitching.

Remove the default server (to avoid collisions):
```
  sudo rm /etc/apache2/sites-enabled/000-default.conf   ## which is a symlink anyhow
```
```
  sudo a2ensite rict.liris.cnrs.fr.conf   ## To enable the virtual site
  sudo service apache2 restart            ## Relaunch the service
```
Use Firefox to pop some requests on `http://rict.liris.cnrs.fr/UD-Viz/Vilo3D/index.html`.

Trouble shoot by looking at server's error and log files:
  - `tail -f /var/log/apache2/error.log`
  - `tail -f /var/log/apache2/access.log`

Notes and references:
 * [Ubuntu Apache2 configuration](https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-ubuntu-14-04-lts)
 * [Ubuntu Apache2 install](https://help.ubuntu.com/lts/serverguide/httpd.html)
