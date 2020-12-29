CC=nasm
S=input.asm
DEBUG_FOLDER=debug/
O_FILE=input.o
OUTPUT=input
INCLUDE=-i ~/NASM/NASM_Projects/include/

build:
	$(CC) -f elf64 -o $(O_FILE) $(S)
	ld $(O_FILE) -o $(OUTPUT)

gdb:
	$(CC) $(INCLUDE) -g -f elf64 -o $(DEBUG_FOLDER)hello.a $(S)

clean:
	rm -rf *.o *.a $(OUTPUT) hello.i64
