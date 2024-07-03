MEMORY {
	RAMZ:	start = $0000, size = $0100, type = rw, define = yes;
    RAM:    start = $CE00, size = $0100, type = rw, define = yes, file = "%O";
	ROM:	start = $C000, size = $0E00, type = ro, define = yes, fill=yes file = "%O";
}

SEGMENTS {
	ZEROPAGE: load = RAMZ, type = zp, define = yes;
    BSS: load = RAM, type = rw;
	CODE: load = ROM, type = ro;
}
