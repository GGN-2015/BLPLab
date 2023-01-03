#!/bin/bash

# this script (csv_col.sh) input from stdin and output into stdout.
# the field index range is given from the command line.

script_name=$0
show_help() {
	echo -en "usage: $script_name FIELD_FROM FIELD_TO\n"
	echo -en "       $script_name FIELD_INDEX\n"
}

case $# in
	1)
		FIELD_FROM=$1
		FIELD_TO=$1;;
	2)
		FIELD_FROM=$1
		FIELD_TO=$2;;
	*)
		show_help
		exit 1
esac

output_cnt=0
while read line
do
	if [ -n "$line" ]
	then
		old_ifs=$IFS
		IFS=","

		set $line
		IFS=$old_ifs
		field_id=1
		first=1
		comma_output=0
		while [ $# -gt 0 ]
		do
			if [ $FIELD_FROM -le $field_id ] && [ $field_id -le $FIELD_TO ]
			then
				if [ $first -eq 1 ]
				then
					first=0
				else
					echo -n ","
					comma_output=$((comma_output + 1))
				fi
				echo -n "$1"
			fi
			shift
			field_id=$((field_id + 1))
		done

		comma_cnt=$((FIELD_TO - FIELD_FROM))
		while [ $comma_output -lt $comma_cnt ]
		do
			echo -n ","
			comma_output=$((comma_output + 1))
		done
		echo -en "\n"

		output_cnt=$((output_cnt + 1))
	fi
done

if [ $output_cnt -gt 0 ]
then
	echo -en "\n"
fi

exit 0
