#!/bin/bash

# usage:
#     ./csv_row.sh "ROW_FROM" "ROW_TO"

script_name=$0
show_help() {
	echo "usage: $script_name ROW_FROM ROW_TO"
	echo "       $script_name ROW_INDEX "
}

if [ "$1" = "-h" ] || [ "$1" = "--help" ]
then
    show_help
    exit 0
fi


case $# in
	1)
		ROW_FROM=$1
		ROW_TO=$1;;
	2)
		ROW_FROM=$1
		ROW_TO=$2;;
	*) 
		show_help
		exit 1;;
esac

line_id=1
output_cnt=0
while read line
do
	if [ -n "$line" ]
	then
		if [ $ROW_FROM -le $line_id ] && [ $line_id -le $ROW_TO ]
		then
			echo "$line"
			output_cnt=$((output_cnt + 1))
		fi
		line_id=$((line_id + 1))
	fi
done

if [ $output_cnt -gt 0 ]
then
	echo -en "\n"
fi

