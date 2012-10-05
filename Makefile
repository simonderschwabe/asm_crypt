.PHONY = all

SOURCES = $(wildcard *.asm)
OBJECTS = $(SOURCES:.asm=.o)
TARGETS = asm_crypt

%.o : %.asm
	as -o $@ $<

all: $(TARGETS)

asm_crypt: $(OBJECTS)
	ld -o $@ $^
	rm *.o
