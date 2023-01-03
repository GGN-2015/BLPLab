#!/bin/bash

# this script (csv_setrow.sh) input a CSV file from stdin
# change one row in the file and output the new CSV file to
# stdout. the operation will be ignored if the index is not
# exist in the file.

script_name=$0
show_help() {
	echo -en "usage: $script_name ROW_INDEX \"field-1\" \"field-2\" ... \n"
	echo -en "       $script_name ROW_INDEX \n"
	echo -en "       tips: the original line will be deleted if no field is given.\n"
}

if [ $# -lt 1 ]
then
	show_help
	exit 1
fi

ROW_INDEX=$1
if [ $# -eq 1 ]
then
	delete_mode="on"
else
	delete_mode="off"
fi

line_id=1
output_cnt=0
while read line
do
	if [ -n "$line" ]
	then
		if [ $line_id -ne $ROW_INDEX ]
		then
			echo "$line"
			output_cnt=$((output_cnt + 1))
		else
			if [ "$delete_mode" = "off" ]
			then
				shift
				old_ifs=$IFS
				IFS=","
				echo -n "$*"
				IFS=$old_ifs
				echo -en "\n"
				output_cnt=$((output_cnt + 1))
			fi
		fi
		line_id=$((line_id + 1))
	fi
done

if [ $output_cnt -gt 0 ]
then
	echo -en "\n"
fi

exit 0
