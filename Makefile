.PHONY = all

SOURCES = $(wildcard *.asm)
OBJECTS = $(SOURCES:.asm=.o)
TARGETS = asm_crypt

%.o : %.asm
	as --32 -o $@ $<

all: $(TARGETS)

asm_crypt: $(OBJECTS)
	ld -melf_i386 -o $@ $^
	rm *.o
