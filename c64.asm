
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

.importzp TMP0

; -----------------------------------------------------------------------------
; kernal entry points
SETMSG  = $FF90             ; set kernel message control flag

; -----------------------------------------------------------------------------
; kernal variables
BKVEC   = $0316             ; BRK instruction vector (official name CBINV)

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
        LDA #$80            ; disable kernel control messages
        JSR SETMSG          ; and enable error messages
        BRK


LINKAD: .WORD BREAK             ; address of brk handler

