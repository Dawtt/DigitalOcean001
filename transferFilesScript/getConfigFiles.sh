#!/usr/bin/env bash

#printf '\e[8;25;130t' #set terminal size
clear


#####     VARIABLES & PATHS
LOCAL_ROOT=$(pwd)
source files.sh

###     COPY TYPE
COPY_FILES=true # copies only specified files
COPY_DIRECTORIES_RECURSIVELY=false # UNFINISHED!!! copies all files in recursive specified directories

###     TRANSFER & REMOTE TYPE
TRANSFER_TYPE=
REMOTE_CONFIG=
SCP_COMMAND=
SCP_FILE=
INTRO=

if [[ "$1" = "" ]]; then
        echo "required parameters: -G or -P, -p or -b."
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
        * )                     #usage
                                exit 1
    esac
    shift
done


source ${LOCAL_ROOT}/${REMOTE_CONFIG}

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
printf " List of files to copy from remote server:\n"
# printf ${FILES_LIST[@]}
for fileName in "${FILES_LIST[@]}"
    do
        printf "%10s $fileName \n"
done

echo "Press return to perform task"
read -n1 -r button

set -x # Display the following bash commands in user terminal

# for GET, make sure directory structure exists locally.
if [[ ${TRANSFER_TYPE} = "GET" ]]; then
    for directory in ${DIRECTORIES[@]} # create directories needed.
        do
            mkdir -p ${LOCAL_ROOT}${directory} # -p blocks notification if already exist.
    done
fi

# perform the file transfers.
if ${COPY_FILES}; then
    if [[ ${TRANSFER_TYPE} = "GET" ]]; then
        for fileName in "${FILES_LIST[@]}"
            do
                scp ${REMOTE_USERNAME}@${REMOTE_HOST}:${fileName} ${LOCAL_ROOT}${fileName}
        done
    elif [[ ${TRANSFER_TYPE} = "PUSH" ]]; then
        for fileName in "${FILES_LIST[@]}"
            do
                scp ${LOCAL_ROOT}${SCP_FILE} ${REMOTE_USERNAME}@${REMOTE_HOST}:${SCP_FILE}}
        done
    fi
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
