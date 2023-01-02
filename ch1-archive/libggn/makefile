CFILES=ggn.c
OBJECTS=ggn.o
OUTPUT=libggn.a

all: $(OUTPUT)

clean:
	rm *.o *.a

$(OUTPUT): $(OBJECTS)
	ar crv $(OUTPUT) $(OBJECTS)
	ranlib $(OUTPUT)

$(OBJECTS): $(CFILES)
	gcc -c $(CFILES)

.PHONY: all clean

