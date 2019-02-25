#!/usr/bin/env bash

# spongeCase.sh    (SPoNge Case)
# Thanks http://linuxcommand.org/lc3_wss0120.php for input parameter while / shift statement
# This script is for BASH, should be usable on most macs/linux boxes.
#   I don't anything about windows bash.
#   If you know how to run bash scripts in windows, this script [probably?] will work.

# Usage:
#   If you do not how PATHS or bash profiles work, than:
#
#       1. Place this script into directory you prefer
#       2. Open a CLI / Terminal / etc
#       3. Go to the directory you put this script in
#       4. type:
#               bash sPn.sh words I want sponge cased


clear

# check for parameters for script. Notify user if none, then terminate script.
if [[ "$1" = "" ]]; then
        echo "No input parameter words to change case of. "
        printf "This script requires a string/word parameter input. Example command:\n\n"
        echo "bash sPn.sh words I want sponge cased"
        printf "\nTerminating script.\n\n\n"
        exit 1
fi


###     VARIABLES
stringInput=""
stringArrayIn=()
stringArrayOut=
wordCount=0


# this while loop puts all input "words" into a single array
while [[ "$1" != "" ]]; do          # $1 is variable for input cli parameters to script
    stringInput="$stringInput $1"   # concatenate input strings into stringInput
    stringArrayIn[wordCount]=${1}
    shift                           # shift makes $1 the next parameter which had been input.
done

s=""                                                # $s holds changed characters before appending
STRING_OUT=""                                       # $s gets appended here
SPACE_ADVANCE=0                                     # Increment on spaces, to ignore in pattern output
for (( i=0; i<${#stringInput}; i++ )); do           # for each character in $stringInput
    if [[ "${stringInput:$i:1}" =~ \ |\  ]]; then   # this only identifies a space with regex
        (( SPACE_ADVANCE++ ))                       # increment if there's a space.
    fi

    if !(( ( i + SPACE_ADVANCE ) % 2 )); then       # alternates upper & lower case
            s=$(printf "${stringInput:$i:1}" | tr '[:upper:]' '[:lower:]') # use printf to get character, pip to tr, store in $s
        else
            s=$(printf "${stringInput:$i:1}" | tr '[:lower:]' '[:upper:]') # same as previous, alternating case
    fi
    STRING_OUT="${STRING_OUT}${s}"                  # append $s to $String_Out
done
echo "${STRING_OUT}"

# remove the # in the following line to copy results to MacOS clipboard:
# printf "${STRING_OUT}" |  pbcopy


printf "\n\n"

exit 1                      # terminate script