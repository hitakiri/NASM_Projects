CC=nasm
S=hello.asm
DEBUG_FOLDER=debug/
INCLUDE=-i ~/NASM/NASM_Projects/include/

build:
	$(CC) -f elf64 -o hello.o $(S)
	ld hello.o -o hello

gdb:
	$(CC) $(INCLUDE) -g -f elf64 -o $(DEBUG_FOLDER)hello.a $(S)

clean:
	rm -rf *.o *.a hello hello.i64
