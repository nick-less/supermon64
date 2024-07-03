all: supermon.bin supermon64.bin

clean:
	rm -f *.bin *.o *.map

supermon.bin: supermon64.o c64.o
	ld65 --mapfile supermon.map --config c64.ld  supermon64.o c64.o -o supermon.bin

supermon64.bin: supermon64.o c64.o
	ld65 --mapfile supermon.map --config pet.ld  supermon64.o c64.o -o supermon64.bin


%.o: %.asm
	ca65 $(CAFLAGS65)  -o $@ $< 