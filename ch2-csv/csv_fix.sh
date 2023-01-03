#!/bin/bash

# this script (csv_fix.sh) will change the fields count in
# every line of a CSV file. it input from stdin a CSV file
# and output to stdout the changed file.

script_name=$0
show_help() {
	echo -en "usage: $script_name NEW_FIELD_CNT\n"
}

if [ "$1" = "-h" ] || [ "$1" = "--help" ]
then
	show_help
	exit 0
fi

if [ "$(which csv_col.sh)" = "" ] && [ "$CSV_TOOLS_PATH" = "" ]
then
	echo -en "you need to include CSV_TOOLS_PATH into \$PATH,\n"
	echo -en "or set CSV_TOOLS_PATH to the location of the csv tools.\n"
	exit 1
fi

if [ "$CSV_TOOLS_PATH" != "" ]
then
	CSV_COL_SH=$CSV_TOOLS_PATH/csv_col.sh
else
	CSV_COL_SH=csv_col.sh
fi

if [ $# -ne 1 ]
then
	show_help
	exit 1
fi

NEW_FIELD_CNT=$1
"$CSV_COL_SH" 1 $NEW_FIELD_CNT
