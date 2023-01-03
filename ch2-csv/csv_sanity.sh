#!/bin/bash

# this script (csv_sanity.sh) input a CSV file from stdin,
# erase all the empty line in the input and output it to stdout.
# if nothing is changed in this step, the script exit with 0
# or else it exist with a non-zero value.
#
#
empty_cnt=0
non_empty_cnt=0
while read line
do
	last_line="$line"
	if [ -n "$line" ]
	then
		echo "$line"
		non_empty_cnt=$((non_empty_cnt + 1))
	else
		empty_cnt=$((has_empty + 1))
	fi
done

if [ $non_empty_cnt -gt 0 ]
then
	echo -en "\n"
fi

if [ $empty_cnt -eq 1 ] && [ -z "$last_line" ]
then
	exit 0 # has empty line to delete or the last line is not empty 
else
	exit 1 # has no empty line to delete
fi

