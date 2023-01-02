#!/bin/bash
tmpfile=/tmp/mytmp_$$_test.tmp

# include `my_dialog.sh`
. ./my_dialog.sh

pause() {
	echo -en "press enter to continue ..."
	read
	echo -e ""
}

# demo: msgbox
dialog_msgbox "title" "this is a msgbox."
echo return=$?
pause

# demo: checklist
dialog_checklist "title" "this is a checklist" 3 "opt1" "opt2" "opt3" 2> $tmpfile
echo return=$?
check=$(cat $tmpfile)
echo check=$check
pause

# demo: menu
dialog_menu "title" "this is a menu" 4 "start" "load" "settings" "quit" 2> $tmpfile
echo return=$?
menu=$(cat $tmpfile)
echo menu=$menu
pause

