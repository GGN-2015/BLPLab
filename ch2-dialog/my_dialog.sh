#!/bin/bash

# this file contains many functions about the usage of `dialog`
# make sure that your system has been equiped with command
# `dialog` before you try these functions.

DEFAULT_WIDTH=54
DEFAULT_HEIGHT=18

# `dialog_msgbox` will show a message box in the terminal
# with an <OK> button.
#
# usage: 
#     dialog_msgbox "TITLE"
#     dialog_mxgbox "TITLE" SIZE_X SIZE_Y
#
#     the default values are
#         SIZE_X=$DEFAULT_HEIGHT
#         SIZE_Y=$DEFAULT_WIDTH
# 
# return value:
#     if the "OK" button is pushed, the return value is 
#         0 (true);
#     if dialog terminated by interruption, the return
#         value is 1 (false).
dialog_msgbox() {
	local TITLE=$1
	local SIZE_X=${2:-$DEFAULT_HEIGHT}
	local SIZE_Y=${3:-$DEFAULT_WIDTH}

	dialog --msgbox "$TITLE" $SIZE_X $SIZE_Y
	local ans=$?
	dialog --clear
	return $ans
}

# dialog_checklist shows a checklist in the terminal
# there is collection of choices and you can choose
# a subset from the collection.
#
# usage: 
#     dialog_checklist "TITLE" "PROMPT" CHOICE_CNT ...
#
#     you should put the list of choices instead of `...`
#
# warning:
#     you should put each of choice into a double quote,
#     but you should not use something like "hello \" abc",
#     because the imperfection of our capsulation.
#
# return value:
#     if OK is pushed, the function return 0 (true)
#         and the selected set will be output to stderr (2)
#     if Cancel is pushed, the function return 123 (false)
#         and will not output to stderr
dialog_checklist() {
	local TITLE=$1
	local PROMPT=$2
	local SIZE_X=$DEFAULT_HEIGHT
	local SIZE_Y=$DEFAULT_WIDTH
	local CHOICE_CNT=$3

	shift; shift; shift
	local TMPFILE=/tmp/mytmp_$$.tmp
	local TMPFILE2=/tmp/mytmp_$$.out
	rm -f $TMPFILE
	echo -en "--title \"$TITLE\" --checklist \"$PROMPT\" " >> $TMPFILE
	echo -en "$SIZE_X $SIZE_Y $CHOICE_CNT " >> $TMPFILE

	local x=1
	while [ $x -le $CHOICE_CNT ]
	do
		echo -n $x "\"$1\"" "\"off\" " >> $TMPFILE
		x=$(($x + 1))
		shift
	done

	# get the answer of dialog	
	cat $TMPFILE | xargs dialog 2> $TMPFILE2
	local ans=$?
	rm -f $TMPFILE
	dialog --clear

	# output the answer selected
	cat $TMPFILE2 1>&2
	echo -e ""
	rm -f $TMPFILE2

	# return the value of state
	return $ans
}

# dialog_msgbox "hello world!"
# dialog_checklist "title" "prompt" 4 "one" "two" "three" "four"
# echo ans=$?

