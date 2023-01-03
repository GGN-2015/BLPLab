# ch2-csv

in the chapter2 of book `BLP(4th)`, a CD message storage manager is
provided by the author in order to pratice the shell programming skills
of the readers. in this lab, we provides a series of shell scripts
which facilitates the usage of CSV (Comma Seperated Values) data file,
for a same purpose.

first we need to define the basic structure of a CSV file. in our
context, the definition of a CSV file may be very different with the
general definitions for CSV.

## descriptions for CSV and its parser
1. a CSV file can be an empty file, but there should be no empty line
in our CSV file except for the last line. besides, the last bytes of a 
CSV file should be '\n',and '\n' should be the seperator of different 
lines (linux style). so if you try to change a CSV file with an editor 
program, make sure that this rule is obeyed, or our scripts may crash.
2. if there are N commas in a line of data, it means that there are N+1
data fields in this line. for example, if there is no comma on a certain
line of data, it means that there is only one data field in this line.
3. when we are loading data from a CSV file, we need to assure that
the empty characters such as spaces and tabs be reserved as a part
of data.
4. if there is N data fields on a certain line (as is defined, there
is no empty line in a CSV file, so N must be a positive integer), we
say that the index of the datas in a line is 1 to N. if we want to get
the Mth data field in a line where M < 1 or M > N, the program should
return an empty stringas the result.
5. all lines in data is labeled from 1 to N when there are N data lines
in total in a CSV file. in logic, the order of all the records is not
important just like in some database, while the order of all the field
in a single record is important information.

## provided scripts
- `csv_sanity.sh` is used to check if there is any empty line in a
CSV file, as well as correct this error to obey desciption-1.
- `csv_row.sh` is used to get certain lines of data from a sanitized
csv file. if a so called CSV file is not in sanity, the script will
automatically sanitize it in logic, all the following tools has this 
feature.
- `csv_col.sh` is used to get certain columns of data from a sanitized
csv file. as is defined in desciption-4, if some line of data doesn't 
has a certain index of data field, return an empty string as the data.
- `csv_setrow.sh` change one row of a CSV file and keep all other row
as the original value. if the row index for changing is not found in
the CSV file, the operation will be ignored and the original file will
be output directly.
- `csv_fix.sh` fix the fields count to a new value given in command
line. if the original field count is less than the given value, new
fields will be added, or else the last few fields will be deleted
from the original line. `csv_fix.sh` call `csv_col.sh` to implement
its own function. in the next section we will focus on that 
`csv_fix.sh` can only run properly under two circumstances:

> 1. environment variable `$CSV_TOOLS_PATH` is set properly.
> 2. current path of these scripts are added into variable `$PATH`.
>
- `csv_setpos.sh` change one pos in the csv file, you need to pass
the row index and field index from command line and set a new value
for this element in CSV file.
- `csv_len.sh` get the number of records (non-empty line), in a CSV 
file and output the answer to stdout.

all these scrpts input from stdin and output to stdout, this feature
allows us to use pipe to filter a text CSV data in shell scripts.

## before the usage of provided scripts
before used, you should run command in script directory:

```bash
chmod +x *.sh
export CSV_TOOLS_PATH=$(pwd)
```

these command will change all the `.sh` file in the current directory
into mode of runnable file. if you want to use this tools in any
position in your system, you can add current path into `$PATH` by input
command:

```bash
echo -en "export PATH=\$PATH:$(pwd)\n" >> $HOME/.bashrc
source $HOME/.bashrc
```

if the scirpts path `.../ch2-csv` is not listed in \$PATH, you should
run command `export CSV_TOOLS_PATH=$(pwd)` every time when you startup
the demos, so we recommand that you change the environment variable
`$PATH` temporarily.

## examples for usage

we assume that you run these following command in the scripts' directory.
and you haven't add this directory into environment variable `$PATH`,
while you have set the value of `CSV_TOOLS_PATH` properly.

```bash
# output the first field in all record in score.csv
cat score.csv | ./csv_col.sh 1 

# output the second field to the fourth field of all record in score.csv
cat score.csv | ./csv_col.sh 2 4

# get the number of records in score.csv
cat score.csv | ./csv_len.sh

# get the value of row-2nd field-3rd from score.csv
cat score.csv | ./csv_setpos.sh 2 3 2>&1 1>/dev/null

# change the value of row-2nd field-3rd to "xxx" and output the changed table
# the original file score.csv will not be changed.
cat score.csv | ./csv_setpos.sh 2 3 "xx" 2>/dev/null

# output the first record in score.csv
cat score.csv | ./csv_row.sh 1

# output row-2nd to row-3rd in score.csv
cat score.csv | ./csv_row.sh 2 3

# set a new value for row-2nd in score.csv, the original file will not be changed
cat score.csv | ./csv_setrow.sh 2 "wcd" "99" "91" "98" "92" "97" 2>/dev/null

# in some case, different records in a CSV may have different fields' count,
# use csv_fix.sh to set a fixed fields count, in this example,
# no matter how many fields of a record originally has, it will be fixed to 3.
# if there are more than 3 fields in a record, first 3 fields will be kept.
# if there are less than 3 fields in a record, empty fields will be added.
cat score.csv | ./csv_fix.sh 3

# to add a new record into a csv file, you can at first append the record at
# the end of a CSV file, then use csv_sanity.sh to delete the empty lines.
echo "wzq,95,94,96,93,97" >> score.csv
cat score.csv | ./csv_sanity.sh > score.csv.tmp
mv score.csv.tmp score.csv

# delete the 5th record in score.csv
cat score.csv | ./csv_setrow.sh 5 2>/dev/null >score.csv.tmp
mv score.csv.tmp score.csv
```

