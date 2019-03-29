#Status Checks & Logging
* `sudo tail -F /var/log/apache2/error.log /var/log/apache2/mod_jk.log /var/log/apache2/access.log /var/lib/tomcat8/logs/catalina.out /var/log/trafficserver/traffic.out /var/log/trafficserver/diags.log /var/log/trafficserver/error.log /var/log/trafficserver/manager.log`
* `| grep --color=always catalina\|tomcat\|mod_jk` add to filter for lines containing catalina or tomcat & color them
* `| grep --color=always -E "$|tomcat"`
* `sudo systemctl status tomcat8`
* `sudo systemctl status apache2`
* `sudo service tomcat8 restart && sudo service apache2 restart`

#Tomcat
* `ps aux | grep catalina`  Get ${CATALINA_HOME}
* `/usr/share/tomcat8/bin$ sh version.sh` get version
* `/usr/share/tomcat8/lib$ java -cp catalina.jar org.apache.catalina.util.ServerInfo` get tomcat version
## Permissions
* `/var/lib/tomcat8/conf/`  
  * files owned by root, group tomcat8
  * 775


## Paths
* catalina.base=`/var/lib/tomcat8` base is essentially config & log files for a specific instance of tomcat (in case more than one will be used). Note seperate instances will have their own webapps, so /webapps is in base, etc.
* catalina.home=`/usr/share/tomcat8` tomcat running scripts, libraries, etc.
* `/usr/share/tomcat8/bin` tomcat scripts
* webapps directory `/var/lib/tomcat8/webapps`
* `sudo nano /var/lib/tomcat8/conf/server.xml`
* `sudo /var/lib/tomcat8/conf/catalina.properties`
* `sudo /var/lib/tomcat8/conf/tomcat-users.xml`
* `sudo /var/lib/tomcat8/conf/web.xml`

#Mod_jk
* `sudo nano /etc/libapache2-mod-jk/workers.properties`
* 

#Apache2
* `sites-available` is the one to edit. `sites-enabled` should simlink to correct sites in `sites-enabled`.
* `sudo nano /etc/apache2/sites-enabled/000-default.conf`
* `sudo nano /etc/apache2/sites-available/000-default.conf`
* `sudo nano /etc/apache2/apache2.conf`
* `sudo nano /etc/apache2/mods-available/jk.conf`
* 

#Tomcat
* `httpd.conf` on debian is `apache2.conf`


#Traffic Server

#Linux General
* `sudo reboot`
* `sudo service $SERVICE restart` restart for apache2 or tomcat8 etc
* `sudo rm -r <directory>` Deletes a directory
* `q` quits certain menus, where ctrl+c does not
* `cut -d : -f 1 /etc/passwd` list all users
* `cut -d : -f 1 /etc/group` list all groups
* `sudo find / -type d -user $USER -perm /u=w` find writable directories for user $USER
* `sudo chown -R tomcat8:tomcat8 /var/lib/tomcat8/conf/*`
* `dpkg -l|grep tomcat` show all packages related to tomcat