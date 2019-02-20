#Status Checks & Logging
* `sudo tail -qF /var/log/apache2/error.log /var/log/apache2/mod_jk.log /var/log/apache2/access.log`
* `sudo systemctl status tomcat8`
* `sudo systemctl status apache2`

#Tomcat
* `sudo nano /var/lib/tomcat8/conf/server.xml`
* `sudo /var/lib/tomcat8/conf/catalina.properties`
* `sudo /var/lib/tomcat8/conf/tomcat-users.xml`
* `sudo /var/lib/tomcat8/conf/web.xml`

#Mod_jk
* `sudo nano /etc/libapache2-mod-jk/workers.properties`
* 

#Apache2
* `sudo nano /etc/apache2/sites-available/000-default.conf`
* `sudo nano /etc/apache2/apache2.conf`
* `sudo nano /etc/apache2/mods-available/jk.conf`
* 

##Notes
* `httpd.conf` on debian is `apache2.conf`
* `sites-available` is the one to edit. `sites-enabled` should simlink to correct sites in `sites-enabled`.
* `sudo nano /etc/apache2/sites-enabled/000-default.conf`
* 

#Traffic Server


