#!/usr/bin/env bash

printf '\e[8;25;130t' #set terminal size
clear

#########     VARIABLES & PATHS         ############

###     COPY TYPE
COPY_FILES=true # copies only specified files
COPY_DIRECTORIES_RECURSIVELY=false # copies all files in recursive specified directories

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

###     CHOOSE CORRECT CONFIG FILE
printf "\n\n\n###########################################################################"
printf "\n      %10s Please Choose Config File \n"
printf "###########################################################################"
printf "\n\n\ Press p for pi, b for belly; followed by <ENTER>.\n\n"
read usrconf
if [[ "$usrconf" = "p" ]]; then
    source configpi.sh
fi
if [[ "$usrconf" = "b" ]]; then
    source configdo.sh
fi
#########       END VARIABLES & PATHS         ############



###     BEGIN SCRIPT

printf "\n\n\n###########################################################################"
printf "\n      %10s ${INTRO} \n" # $Intro is from config file source
printf "###########################################################################"
printf "\n\n"
printf " %10s Script Settings:\n"
printf " Local root directory: %10s $LOCAL_ROOT\n"
printf " List of files to copy from remote server:\n"
# printf ${FILES_LIST[@]}
for fileName in "${FILES_LIST[@]}"
    do
        printf "%10s $fileName \n"
done

echo "Press return to perform task"
read -n1 -r button

set -x # Display the following bash commands in user terminal
for directory in ${DIRECTORIES[@]} # create directories needed.
    do
        mkdir -p ${LOCAL_ROOT}${directory} # -p blocks notification if already exist.
done

if ${COPY_FILES}; then
    for fileName in "${FILES_LIST[@]}"
        do
            mkdir -p ${LOCAL_ROOT}${directory}
            scp ${REMOTE_USERNAME}@${REMOTE_HOST}:${fileName} ${LOCAL_ROOT}${fileName}
    done
fi

if ${COPY_DIRECTORIES_RECURSIVELY}; then
    for directory in "${DIRECTORIES_RECURSIVE_COPY_LIST[@]}"
        do
            scp -r ${REMOTE_USERNAME}@${REMOTE_HOST}:${directory} ${LOCAL_ROOT}${directory}
    done
fi

set +x # stop displaying bash commands in user terminal.
###         END SCRIPT
