#!/usr/bin/env bash



# Apply permissions
    if  ${CORRECT_PERMISSIONS}; then
        for command in "${PERMISSIONS_COMMANDS[@]}"
            do
                ssh ${REMOTE_PORT_SSH} ${REMOTE_USERNAME}@${REMOTE_HOST} ${command}
        done
    fi


/var/lib/tomcat8/conf
/Catalina/localhost
/Catalina

sudo chown -R root:tomcat8 /var/lib/tomcat8/conf/*
sudo chown root:root /etc/libapache2-mod-jk/workers.properties

sudo chmod -R 640 /var/lib/tomcat8/conf/*
chmod -R 644 /var/lib/tomcat8/conf/Catalina/localhost/*
chmod 775 /var/lib/tomcat8/conf/Catalina
chmod 755 /var/lib/tomcat8/conf/Catalina/localhost
chmod 755 /var/lib/tomcat8/conf/policy.d



