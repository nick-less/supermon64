#supermon64.prg: relocate.prg supermon64-8000.prg supermon64-C000.prg
#	./build.py $^ $@

#supermon64-8000.prg: supermon64.asm
#	64tass -i $< -o $@ -DORG='$$8000'

#supermon64-C000.prg: supermon64.asm
#	64tass -i $< -o $@ -DORG='$$C000'

#relocate.prg: relocate.asm
#	64tass -i $< -o $@

all: supermon64.bin

clean:
	rm -f *.bin *.o

supermon64.bin: supermon64.o
	ld65 --config pet.ld  supermon64.o -o supermon64.bin

%.o: %.asm
	ca65 $(CAFLAGS65)  -o $@ $< 