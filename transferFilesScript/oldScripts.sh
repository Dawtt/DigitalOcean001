#!/usr/bin/env bash











###     BEGIN SCRIPT

printf "\n\n\n###########################################################################"
printf "\n      %10s ${INTRO_GET} \n" # $Intro is from config file source
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
