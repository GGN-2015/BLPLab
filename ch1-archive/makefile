useggn: useggn.c ./libggn/libggn.a
	gcc -o useggn useggn.c -L./libggn -lggn

all: useggn

run: useggn
	./useggn

clean:
	rm useggn

.PHONY: all clean

