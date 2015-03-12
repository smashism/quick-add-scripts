#!/bin/sh

#
# prompts IT member to enter computer name
# updates hostname before binding to AD
# adapted by github.com/shashism
# last updated 2015-03-11
#

# Set CocoaDialog Location
CD="/path/to/cocoaDialog.app/Contents/MacOS/cocoaDialog"

# Dialog to enter the computer name and the create $ASSETTAG variable
rv=($("$CD" standard-inputbox --title "Computer Name" --no-newline --informative-text "Enter the Computer Name (Based on Asset Tag)" --value-required))
COMPNAME=${rv[1]}


# Set Hostname using variable created above
sudo scutil --set ComputerName $COMPNAME
sudo scutil --set LocalHostName $COMPNAME
sudo scutil --set HostName $COMPNAME


# Dialog to confirm that the hostname was changed and what it was changed to.
tb=`"$CD" ok-msgbox --text "Computer name updated!" \
--informative-text "The computer's hostname has been added to $COMPNAME." \
--no-newline --float`
if [ "$tb" == "1" ]; then
echo "User said OK"
elif [ "$tb" == "2" ]; then
echo "Canceling"
exit
fi
