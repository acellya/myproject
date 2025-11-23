        ORG     0000H
        LJMP    MAIN

        ORG     0100H

LOWBYTE     EQU     30H        ; save A (LSB)

MAIN:
        LCALL   LCD_CLR

        ; example values
        MOV     A, #12         ; first value
        MOV     B, #5          ; second value

        ; multiplication
        MUL     AB             ; A = LSB, B = MSB

        ; show result
        MOV     LOWBYTE, A     ; save LSB
        MOV     A, B
        JZ      ONE_BYTE_RESULT

TWO_BYTE_RESULT:
        ; two-byte result: show MSB then LSB
        LCALL   WRITE_HEX      ; print MSB
        MOV     A, LOWBYTE     ; restore LSB
        LCALL   WRITE_HEX
        SJMP    END_PROGRAM

ONE_BYTE_RESULT:
        ; one-byte result: print LSB only
        MOV     A, LOWBYTE
        LCALL   WRITE_HEX

END_PROGRAM:
HERE:   SJMP    HERE
