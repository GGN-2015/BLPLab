#!/bin/bash

# this scripts (csv_len.sh) input a CSV file from stdin, and
# output the number of records in it to stdout.

line_cnt=0
while read line
do
	if [ -n "$line" ]
	then
		line_cnt=$((line_cnt + 1))
	fi
done

echo "$line_cnt"
exit 0

