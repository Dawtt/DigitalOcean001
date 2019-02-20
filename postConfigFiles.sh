#!/usr/bin/env bash

printf '\e[8;25;130t' #set terminal size
clear

#########     VARIABLES & PATHS         ############

###     COPY TYPE
COPY_FILES=true # copies only specified files
COPY_DIRECTORIES_RECURSIVELY=false # copies all files in recursive specified directories



###     CHOOSE CORRECT CONFIG FILE
printf "\n\n\n###########################################################################"
printf "\n      %10s Please Choose Config File \n"
printf "###########################################################################"
printf "\n\n\ Press p for pi, b for belly; followed by <ENTER>.\n\n"
read usrconf
if [[ "$usrconf" = "p" ]]; then
    source ${LOCAL_ROOT}/configpi.sh
fi
if [[ "$usrconf" = "b" ]]; then
    source ${LOCAL_ROOT}/configdo.sh
fi
#########       END VARIABLES & PATHS         ############



###     BEGIN SCRIPT

printf "\n\n\n###########################################################################"
printf "\n      %10s ${INTRO_POST} \n" # $Intro is from config file source
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


if ${COPY_FILES}; then
    for fileName in "${FILES_LIST[@]}"
        do
            mkdir -p ${LOCAL_ROOT}${directory}
           scp ${LOCAL_ROOT}${fileName} ${REMOTE_USERNAME}@${REMOTE_HOST}:${fileName}}
    done
fi


#if ${COPY_DIRECTORIES_RECURSIVELY}; then
#    for directory in "${DIRECTORIES_RECURSIVE_COPY_LIST[@]}"
#        do
#            scp -r ${REMOTE_USERNAME}@${REMOTE_HOST}:${directory} ${LOCAL_ROOT}${directory}
#    done
#fi

set +x # stop displaying bash commands in user terminal.
###         END SCRIPT
