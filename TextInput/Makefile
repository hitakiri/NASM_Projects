CC=nasm
S=input.asm
DEBUG_FOLDER=debug/
O_FILE=input.o
OUTPUT=input
INCLUDE=-i ~/NASM/NASM_Projects/include/

build:
	$(CC) -f elf64 -o $(O_FILE) $(S)
	ld -s $(O_FILE) -o $(OUTPUT)
	#$(CC) -f bin -o $(OUTPUT) $(S)

gdb:
	$(CC) $(INCLUDE) -g -f elf64 -o $(DEBUG_FOLDER)hello.a $(S)

clean:
	rm -rf *.o *.a $(OUTPUT) hello.i64
