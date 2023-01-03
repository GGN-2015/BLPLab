#!/bin/bash

# this script (scv_setpos.sh) will input a CSV file from stdin
# and output the modified file into stdout, and the modification
# is the change of one position indexed by row_id and field_id.
# the original value of that position will be output in stderr.

script_name=$0
show_help() {
	echo -en "usage: $script_name ROW_ID FIELD_ID \"NEW_VALUE\".\n"
}

if [ "$1" = "-h" ] || [ "$1" = "--help" ]
then
	show_help
	exit 0
fi

if [ "$(which csv_row.sh)" = "" ] && [ "$CSV_TOOLS_PATH" = "" ]
then
    echo -en "you need to include CSV_TOOLS_PATH into \$PATH,\n"
    echo -en "or set \$CSV_TOOLS_PATH to the location of the csv tools.\n"
    exit 1
fi

if [ "$CSV_TOOLS_PATH" != "" ]
then
    CSV_ROW_SH=$CSV_TOOLS_PATH/csv_row.sh
	CSV_SETROW_SH=$CSV_TOOLS_PATH/csv_setrow.sh
else
    CSV_ROW_SH=csv_row.sh
	CSV_SETROW_SH=csv_setrow.sh
fi

case $# in
	2)
		ROW_ID=$1
		FIELD_ID=$2;;
	3)
		ROW_ID=$1
		FIELD_ID=$2
		NEW_VALUE=$3;;
	*)
		show_help
		exit 1;;
esac

tmpfile=/tmp/$$_tmpfile.tmp
rm -f $tmpfile
touch $tmpfile # create tmpfile

while read line
do
	if [ -n "$line" ]
	then
		echo "$line" >> $tmpfile # save all data into tmpfile
	fi
done

original_row=$(cat $tmpfile | "$CSV_ROW_SH" $ROW_ID)

if [ "$original_row" = "" ]
then
	cat $tmpfile
	echo -en "\n"
	rm -f $tmpfile
	exit 1
fi

new_row=
old_ifs=$IFS
IFS=","
set $original_row
IFS=$old_ifs

x=1
first=1
old_value=
while [ $# -gt 0 ]
do
	if [ $first -eq 1 ]
	then
		first=0
	else
		new_row="$new_row,"
	fi

	if [ $x -eq $FIELD_ID ]
	then
		new_row="$new_row$NEW_VALUE"
		old_value="$1"
	else
		new_row="$new_row$1"
	fi
	shift
	x=$((x + 1))
done

cat $tmpfile | "$CSV_SETROW_SH" $ROW_ID "$new_row" 2> /dev/null
echo "$old_value" 1>&2

rm -f $tmpfile
exit 0

