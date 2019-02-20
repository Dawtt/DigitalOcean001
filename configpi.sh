#!/usr/bin/env bash


# For Pi
REMOTE_USERNAME="-P 23835 root"
REMOTE_HOST="68.168.165.164"
LOCAL_ROOT="/Users/dw/Dropbox/GitHub/DigitalOcean001/pi"
INTRO_GET="THIS WILL COPY FILES FROM THE PI"
INTRO_POST="POSTING TO PI!!!!!!!!!!!!!!!!!!!"

###     FILES TO BE COPIED ARRAY
FILES_LIST=("/etc/apache2/apache2.conf"
"/etc/apache2/sites-available/000-default.conf"
"/etc/apache2/sites-enabled/000-default.conf"
"/etc/libapache2-mod-jk/workers.properties"
"/etc/apache2/mods-available/jk.conf"
"/var/lib/tomcat8/conf/server.xml"
"/var/lib/tomcat8/conf/catalina.properties"
"/var/lib/tomcat8/conf/tomcat-users.xml"
"/var/lib/tomcat8/conf/web.xml")
###     DIRECTORIES REQUIRED FOR FILE CREATION ARRAY
DIRECTORIES=("/etc/apache2/"
"/etc/apache2/sites-available/"
"/etc/apache2/sites-enabled/"
"/etc/libapache2-mod-jk/"
"/etc/apache2/mods-available"
"/var/lib/tomcat8/conf/")

###     DIRECTORIES FOR RECURSIVE COPY OPTION ARRAY
DIRECTORIES_RECURSIVE_COPY_LIST=("/etc/apache2/"
"/etc/libapache2-mod-jk/"
"/var/lib/tomcat8/conf/")