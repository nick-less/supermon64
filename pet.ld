MEMORY {
	RAMZ:	start = $0000, size = $0100, type = rw, define = yes;
    RAM:    start = $027A, size = $0100, type = rw, define = no, file = "";
	ROM:	start = $9000, size = $1000, type = ro, define = yes, fill=yes file = "%O";
}

SEGMENTS {
	ZEROPAGE: load = RAMZ, type = zp, define = yes;
    BSS: load = RAM, type = rw;
	CODE: load = ROM, type = ro;
}
