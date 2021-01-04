CC=nasm
S=usePtr.asm
DEBUG_FOLDER=debug/
O_FILE=usePtr.o
OUTPUT=usePtr
INCLUDE=-i ~/NASM/NASM_Projects/include/

build:
	$(CC) -f elf64 -o $(O_FILE) $(S)
	ld $(O_FILE) -o $(OUTPUT)

gdb:
	$(CC) $(INCLUDE) -g -f elf64 -o $(DEBUG_FOLDER)hello.a $(S)

clean:
	rm -rf *.o *.a *.i64 $(OUTPUT)
