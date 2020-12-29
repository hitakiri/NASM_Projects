CC=nasm
S=hello.asm
DEBUG_FOLDER=debug/

build:
	$(CC) -f elf64 -o hello.o $(S)
	ld hello.o -o hello

gdb:
	$(CC) -g -f elf64 -o $(DEBUG_FOLDER)hello.a $(S)

clean:
	rm -rf *.o hello hello.i64
