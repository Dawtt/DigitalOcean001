
# Server Setup
* http://157.230.174.54/
* user dw; ssh from mac
* trafficserver used as reverse proxy to apache server 
    * http://157.230.174.54:8080 to 127.0.0.1:80
    * http://152.230.174.54:9024/ http://127.0.0.1:9024
* tomcat user & group tomcat
* /3EX to lead to tomcat

# Server Setup Steps Taken
1. Create Debian Droplet
1. Add SSH login    [(source)](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-debian-9)
    * `LOCAL_MACHINE$ pbcopy < ~/.ssh/id_rsa.pub`
    * paste into DO droplet creation page
    * username:         dw
    * server host name: deb-belly
    * reset root password as denied ssh login (public key)
    * ssh with root@
    * `adduser dw`
    * `usermod -aG sudo dw`
    * LOCAL_MACHINE$ `cat ~/.ssh/id_rsa.pub` (copy key)
    * SERVER/dw$ `mkdir -p ~/.ssh`
    * echo COPIED_PUBLIC_KEY >> ~/.ssh/authorized_keys
    * chmod -R go= ~/.ssh
    * chown -R dw:dw ~/.ssh
1. Apache server & traffic server install [here](https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-traffic-server-as-a-reverse-proxy-on-ubuntu-14-04)
    * `sudo apt-get update && sudo apt-get install trafficserver`
    * `sudo apt-get update && install apache2`
    * `sudo nano /etc/apache2/ports.conf`
    * edit `etc/apache2/ports.conf
        * `Listen 80` changed to `Listen 127.0.0.1:80`
    * edit `/etc/apach2/apache2.conf`
        * Add to end `ServerName localhost`
    * edit `/etc/trafficserver/remap.config`
        * Add to end `map http://your_server_ip:8080/ http://127.0.0.1:80/`
    * `sudo traffic_ctl config reload`
    * did not do extended cache setup [here](https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-traffic-server-as-a-reverse-proxy-on-ubuntu-14-04)
1. Tomcat [digital ocean](https://www.digitalocean.com/community/tutorials/install-tomcat-9-ubuntu-1804)
    * created directories work/ temp/ logs/ in order to give tomcat ownership
1. Tomcat [do-over](https://www.linode.com/docs/development/frameworks/apache-tomcat-on-ubuntu-16-04/), DO's guide apparently has common problems. 
1. mod_jk install & update
    * `sudo nano /etc/libapache2-mod-jk/workers.properties`. Add workers.tomcat_home=/var/lib/tomcat8  workers.java_home=/usr/lib/jvm/java-8-openjdk-amd64/jre
    * `sudo nano /etc/apache2/sites-available/000-default.conf` . JkMount /3EX/* ajp13_worker
    
    
    
    
    
# Passwords
* f855c47e8f49bf4bfdb54c89    (initial root)
* f855c47e8f49bfdb54c89       (update)