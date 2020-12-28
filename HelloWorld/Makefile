build:
	nasm -f elf64 -o hello.o hello.asm
	ld hello.o -o hello

gdb:
	nasm -g -f elf64 -o debug/hello.a hello.asm

clean:
	rm -rf *.o hello
