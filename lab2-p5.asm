        ORG     0000H
        LJMP    MAIN

        ORG     0100H

TOTAL   EQU     30H
TEMP    EQU     31H
BCDNUM  EQU     32H

MAIN:
        LCALL   LCD_CLR
        MOV     TOTAL, #00H

NEXT_INPUT:
        ; Read key
        LCALL   WAIT_KEY        ; A = ASCII digit
        LCALL   WRITE_DATA      ; show digit

        ; ASCII -> number
        CLR     C
        SUBB    A, #'0'
        MOV     TEMP, A

        ; Add to TOTAL
        MOV     A, TOTAL
        ADD     A, TEMP
        MOV     TOTAL, A

        ; Show '='
        MOV     A, #'='
        LCALL   WRITE_DATA

        ; Convert TOTAL to BCD
        MOV     A, TOTAL
        MOV     B, #10
        DIV     AB              ; A = tens, B = ones
        SWAP    A
        ANL     A, #0F0H
        ORL     A, B
        MOV     BCDNUM, A

        ; Display result
        MOV     A, BCDNUM
        LCALL   WRITE_HEX

        ; Show '+' for next input
        MOV     A, #'+'
        LCALL   WRITE_DATA

        SJMP    NEXT_INPUT
