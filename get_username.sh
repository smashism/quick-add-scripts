#!/bin/sh

#
# prompts for username associated with machine
# meant to add user to JSS for user assignment
# adapted by github.com/smashism
# last updated 2015-03-11
#

# Set CocoaDialog Location
CD="/path/to/cocoaDialog.app/Contents/MacOS/cocoaDialog"

# Dialog to enter the computer name and the create $ASSETTAG variable
rv=($("$CD" standard-inputbox --title "Company Username" --no-newline --informative-text "Enter the username of the user assigned to this machine (firstname_lastname)" --value-required))
USER=${rv[1]}


# Set Hostname using variable created above
jamf recon -endUsername $USER


# Dialog to confirm that the hostname was changed and what it was changed to.
tb=`"$CD" ok-msgbox --text "User Added!" \
--informative-text "The computer's associated user has been set to $USER." \
--no-newline --float`
if [ "$tb" == "1" ]; then
echo "User said OK"
elif [ "$tb" == "2" ]; then
echo "Canceling"
exit
fi
