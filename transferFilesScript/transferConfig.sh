#!/usr/bin/env bash

#printf '\e[8;25;130t' #set terminal size
clear


#####     VARIABLES & PATHS
LOCAL_ROOT='/Users/dw/Dropbox/GitHub/DigitalOcean001/transferFilesScript'
source ${LOCAL_ROOT}/files.sh

###     COPY TYPE
COPY_FILES=true # copies only specified files
CORRECT_PERMISSIONS=true
COPY_DIRECTORIES_RECURSIVELY=false # UNFINISHED!!! copies all files in recursive specified directories

###     TRANSFER & REMOTE TYPE
TRANSFER_TYPE=
REMOTE_CONFIG=
SCP_COMMAND=
SCP_FILE=
INTRO=
ONLY_FIX_PERMISSIONS=false

if [[ "$1" = "" ]]; then
        echo "required parameters: -G or -P, -p or -b. -fp for fix permissions only"
        echo "terminating script."
        exit 1
fi

while [[ "$1" != "" ]]; do    # Thanks http://linuxcommand.org/lc3_wss0120.php for this parameter script
    case $1 in
        -G | --get )            TRANSFER_TYPE="GET"
                                ;;
        -P | --push )           TRANSFER_TYPE="PUSH"
                                ;;
        -p | --pi)              REMOTE_CONFIG="configpi.sh"
                                ;;
        -b | --belly )          REMOTE_CONFIG="configdo.sh"
                                ;;
        -fp | --fixpermissions )ONLY_FIX_PERMISSIONS=true
                                ;;
        * )                     #usage
                                exit 1
    esac
    shift
done


source ${LOCAL_ROOT}/${REMOTE_CONFIG}

if ${ONLY_FIX_PERMISSIONS}; then
    set -x
    for command in "${PERMISSIONS_COMMANDS[@]}"
        do
            ssh ${REMOTE_PORT_SSH} ${REMOTE_USERNAME}@${REMOTE_HOST} ${command}
    done
    exit 1
fi

printf "configuration file will be:\n%5s${LOCAL_ROOT}/${REMOTE_CONFIG}.\n\n press <ENTER> to continue.\n\n"
read waitforuser



#########       END VARIABLES & PATHS         ############



###     BEGIN SCRIPT

printf "\n\n\n###########################################################################"
printf "\n      %10s ${TRANSFER_TYPE}!!! ${INTRO} \n" # $Intro is from config file source
printf "###########################################################################"
printf "\n\n"
printf " %10s Script Settings:\n"
printf " Local root directory:\n%10s $LOCAL_ROOT\n"
printf " List of files to copy:\n"
# printf ${FILES_LIST[@]}
for fileName in "${FILES_LIST[@]}"
    do
        printf "%10s $fileName \n"
done

echo "Press return to perform task"
read -n1 -r button

set -x # Display the following bash commands in user terminal

#if [[ ${TRANSFER_TYPE} = "GET" ]]; then
#    for directory in ${DIRECTORIES[@]} # create directories needed.
#        do
#            mkdir -p ${LOCAL_ROOT}${directory} # -p blocks notification if already exist.
#    done
#fi

# perform the file transfers.
if ${COPY_FILES}; then
    if [[ ${TRANSFER_TYPE} = "GET" ]]; then
        for directory in "${DIRECTORIES[@]}"
            do  # for GET, make sure directory structure exists locally.
                mkdir -p ${LOCAL_ROOT}${directory} # -p blocks notification if already exist.
        done
        for fileName in "${FILES_LIST[@]}"
            do
                rsync -a ${REMOTE_PORT} ${REMOTE_USERNAME}@${REMOTE_HOST}:${fileName} ${LOCAL_ROOT}${fileName}
        done


    elif [[ ${TRANSFER_TYPE} = "PUSH" ]]; then
        for fileName in "${FILES_LIST[@]}"
            do
                rsync -a ${REMOTE_PORT_RSYNC} ${LOCAL_ROOT}${fileName} ${REMOTE_USERNAME}@${REMOTE_HOST}:${fileName}
        done
    fi
    # set needed permissions
#    if  ${CORRECT_PERMISSIONS}; then
#        for command in "${PERMISSIONS_COMMANDS[@]}"
#            do
#                ssh ${REMOTE_PORT_SSH} ${REMOTE_USERNAME}@${REMOTE_HOST} ${command}
#        done
#    fi
fi

# copying all contents of directories list
if ${COPY_DIRECTORIES_RECURSIVELY}; then
    if [[ TRANSFER_TYPE="GET" ]]; then
        SCP_COMMAND="-r ${REMOTE_USERNAME}@${REMOTE_HOST}:${directory} ${LOCAL_ROOT}${directory}"
    elif [[ TRANSFER_TYPE="PUSH" ]]; then
        SCP_COMMAND="-r ${LOCAL_ROOT}${directory}" ${REMOTE_USERNAME}@${REMOTE_HOST}:${directory}
    fi
    for directory in "${DIRECTORIES_RECURSIVE_COPY_LIST[@]}"
        do
            scp ${SCP_COMMAND}
    done
fi


set +x # stop displaying bash commands in user terminal.
###         END SCRIPT
