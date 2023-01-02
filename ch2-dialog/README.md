# ch2-dialog

in this lab, we create some functions in shell scripts to
demonstrate how to use command `dialog`. if	`dialog` is not
installed on your linux, you **must** install it before you
try to start the demo.

for example, you may be able to use command `sudo apt 
install dialog` to install these `dialog` tools on ubuntu, 
if you are not very certain about it, just try to google 
"how can i install command dialog on XXX linux?" and fill in 
XXX with the distribution name of your linux.

in order to check whether `dialog` has been installed on your
system, you can try command `dialog --version`. if the
command has a reasonable output beside "command 'dialog' not
found", `dialog` will have been installed.

## startup demo

scripts in `my_dialog_test.sh` give a demo usage of 
`my_dialog.sh`. in `my_dialog.sh` we defined three functions
to encapsulate the usage of `dialog`. the three functions
are:

1. `dialog_msgbox`    : show a messagebox with button OK 
2. `dialog_checklist` : show a checklist with button OK and Cancel
3. `dialog_menu`      : show a menu with button OK and Cancel

run `bash ./my_dialog_test.sh` to show the three demonstrations.

## usage of `my_dialog.sh`

when you want to use these `dialog functions` in `foo.sh`,
follow these steps:

1. use `source` or `.` command to include `my_dialog.sh`
into `foo.sh`
2. call the function you want and redirect stderr into a temporary
file
3. get the return value of the function
4. judge according to the content of tmpfile and the return value

the usage of these three functions are described in detail in 
the comment of `my_dialog.sh`, and `my_dialog_test.sh` presents 
a usage demo for each of the functions.

if you want to generate a manual from the comment of `my_dialog.sh`,
we suggest you to use this command under current folder:

```bash
grep "^#" my_dialog.sh | grep -v "^#!" | more
```

and the output of the command below descibes the usage/return value/
some other tips of the three functions.

