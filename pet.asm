
.export SUPER
.import BREAK
.import MSGBAS
.import CRLF
.import NMPRNT
.import CVTDEC
.import SUPAD
.import SNDMSG
.import MSG4
.import STRT


.exportzp TMP0
.exportzp TMP2

.export GETIN
.export DSTAT
.export STOP
.export LD
.export INPUT
.export CHROUT
.export WARMSTART



; -----------------------------------------------------------------------------
; temporary pointers
TMP0    = $54               ; used to return input, often holds end address
TMP2    = $59               ; usually holds start address
 
; -----------------------------------------------------------------------------
; kernal entry points
SECOND  = $FF93             ; set secondary address after LISTEN
TKSA    = $FF96             ; send secondary address after TALK
LISTEN  = $FFB1             ; command serial bus device to LISTEN
TALK    = $FFB4             ; command serial bus device to TALK
SETLFS  = $FFBA             ; set logical file parameters
SETNAM  = $FFBD             ; set filename
ACPTR   = $FFA5             ; input byte from serial bus
CIOUT   = $FFA8             ; output byte to serial bus
UNTLK   = $FFAB             ; command serial bus device to UNTALK
UNLSN   = $FFAE             ; command serial bus device to UNLISTEN
CHKIN   = $FFC6             ; define input channel
CLRCHN  = $FFCC             ; restore default devices
INPUT   = $FFCF             ; input a character (official name CHRIN)
CHROUT  = $FFD2             ; output a character
LOAD    = $FFD5             ; load from device
SAVE    = $FFD8             ; save to device
STOP    = $FFE1             ; check the STOP key
GETIN   = $FFE4             ; get a character
WARMSTART = $B000

; -----------------------------------------------------------------------------
; kernal variables
BKVEC   = $0092             ; BRK instruction vector (official name CBINV)

; -----------------------------------------------------------------------------
; set up origin
;        .WEAK
;ORG     = $9519
;        .ENDWEAK
;
;*       = ORG
.code

; -----------------------------------------------------------------------------
; initial entry point

SUPER:  JMP STRT
; not needed
;        LDY #MSG4-MSGBAS    ; display "..SYS "
;        JSR SNDMSG
        LDA SUPAD           ; store entry point address in tmp0
        STA TMP0
        LDA SUPAD+1
        STA TMP0+1
        JSR CVTDEC          ; convert address to decimal
        LDA #0
        LDX #6
        LDY #3
        JSR NMPRNT          ; print entry point address
        JSR CRLF
        LDA LINKAD          ; set BRK vector
        STA BKVEC
        LDA LINKAD+1
        STA BKVEC+1
; does not exist
;        LDA #$80            ; disable kernel control messages
;        JSR SETMSG          ; and enable error messages
        BRK

DSTAT:
LD:
        rts


LINKAD: .WORD BREAK             ; address of brk handler

