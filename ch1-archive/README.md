# ch1-archive
Author: `ggn_2015`
Date  : 2023-01-02

this lab shows how to create an `archive file(.a)` in linux,
as well as how to link it.

## startup a demo
steps to follow:
1. run command `make` in `./libggn`
2. run command `make run` in current directory.

a program named `useggn` will be created and linked with
`./libggn/libggn.a`, call function `ggn_hello`.

## create your own archive file
in detail, when you want to create a `.a` file, follows
these steps:
1. create `xxx.h` which contains all your function signatures
2. create `xxx.c` which include `xxx.h` and implements all
the functions contained in `xxx.h`
3. run command `gcc -c xxx.c` and you will get `xxx.o`,
this `.o` file contains your implemented functions, but it's
not the final file we want
4. run command `ar crv libxxx.a xxx.o`, now, file `libxxx.a`
is what we want as an archive file
5. if you are using Berkeley UNIX or some OS alike, you need
to run command `ranlib libxxx.a` to further assure that
the archive file is completed with a content list

noticed that `xxx` above in `xxx.a`, `xxx.h`, `xxx.o`,
`libxxx.a` should be replaced by your own file name you like.
in our context, we use `ggn` which is the name of the author
to replace it. you need to confirm that your `xxx` has not
been occupied by the original c archive files.

## use your own archive file
after your own `libxxx.a` is created, you can follows these
steps to link it with another program such as `foo.c`.
to make it eazy, we assume that you put the file `foo.c` in
the same directory with your `libxxx.a` and `xxx.h`.

1. in `foo.c` you need to include `xxx.h`
2. when you're compiling `foo.c`, run command 
`gcc -o foo foo.c -L. -lxxx`, in this command, `-L.` means to
include current directory into the `Archive Searching Path`,
and `-lxxx` means that you want to link the output program
with an archive file called `libxxx.a` 
3. then you will get a runnable file called `foo` in the
current directory, noticed that `foo` has been linked with 
`libxxx.a` which is created in the previous step

