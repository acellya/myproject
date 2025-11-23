        ORG     0000H
        LJMP    MAIN

        ORG     0100H

NUM     EQU     30H    ; binary (0–99)
BCDNUM  EQU     31H    ; BCD result

MAIN:
        LCALL   LCD_CLR

        ; example: load binary (e.g., 45)
        MOV     NUM, #45

        ; divide by 10
        MOV     A, NUM
        MOV     B, #10
        DIV     AB          ; A = tens, B = ones

        ; build BCD
        SWAP    A           ; tens to high nibble
        ANL     A, #0F0H    ; keep high nibble
        ORL     A, B        ; add ones nibble
        MOV     BCDNUM, A   ; BCD ready

        ; write to LCD
        MOV     A, BCDNUM
        LCALL   WRITE_HEX   ; show BCD on LCD

HERE:   SJMP    HERE
