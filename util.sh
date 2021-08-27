#!/bin/bash
# helper stuff...

# Applications

# usage
# Returns value specified by key
# exmaple: ${JSONAPP} package.json version
# returns: 1.2.3
JSONAPP="npx @trentm/json -f"

# Returns a UUID
# example: ${GETUUID}
# returns: cdbbf56f-f45e-4929-90e8-e21e6db849be
GETUUID="npx @lbergeron/uuid-cli"

#colors

# Usage: 
# Insert these variables in an "echo" to change the color of the proceeding text
# Example: echo "This is ${fgLtYel}Light Yellow${termReset}."
# Returns: This is Light Yellow.
termReset=$(tput init)
fgLtRed=$(tput bold;tput setaf 1)
fgLtGrn=$(tput bold;tput setaf 2)
fgLtYel=$(tput bold;tput setaf 3)
fgLtBlu=$(tput bold;tput setaf 4)
fgLtMag=$(tput bold;tput setaf 5)
fgLtCya=$(tput bold;tput setaf 6)
fgLtWhi=$(tput bold;tput setaf 7)
fgLtGry=$(tput bold;tput setaf 8)

# emojis
grnCheck="✅"
redX="❌"

# echoNotice
# Usage: echoNotice: "notice to display"
# Used to output a notice without a carriage return to wait for the response of a checkOutput result
# example: echoNotice "Sending rocket to the moon"
#          runCommand "launchRocket -d moon"
# output:
# success: Sending rocket to the moon ✅
# failure: Sending rocket to the moon ❌

echoNotice () { echo -e -n "\n$@... "; }

# checkOutput
# Usage: checkOutput "command to run"
# INTERNAL, used by runCommand below to check the output
# of a command to get the status and report/handle failure

checkOutput() {
  if [ $result -eq 0 ]; then
    # success
    echo "${grnCheck}"
    return
  else
    # failure
    tput bel;tput bel;tput bel;tput bel
    echo "${redX}"
    echo -e "\nPrevious command failed with error level: ${result}"
    echo -e "\nCommand:\n"
    echo "  ${command}"
    echo -e "\nSTDOUT/STDERR:\n"
    echo ${output}
    exit 255
  fi
}

# runCommand
# Usage: runCommand "command to run"
# run a comand and check calls checkOutput to check the output
# of a command to get the status and report/handle failure
# should be used in conjunction with echoNotice above
# example: see echoNotice above for example
# 
runCommand() {
  # $1 command
  command=$@
  output=$((eval $command) 2>&1)
  result="$?" 2>&1
  prevline=$(($LINENO-2))
  checkOutput
}

# # Get version of node 
# getNodeVersion() {

# }
