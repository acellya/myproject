        ORG 0000H
        LJMP MAIN

        ORG 0100H

MAIN:
        LCALL LCD_CLR

        ; Example: load a number into A
        MOV A,#156          ; test value

        ; Save on stack
        PUSH ACC

        ; Convert and display decimal
        LCALL CONV_BCD

        ; Restore original value
        POP ACC

        ; Display in hex
        LCALL DISP_HEX

HERE:   SJMP HERE


; Subroutine: CONV_BCD
; Converts number in A to decimal
; and displays it
CONV_BCD:
        MOV B,#100
        DIV AB               ; A=hundreds, B=remainder
        MOV R0, A            ; hundreds
        MOV A, B             ; remainder
        MOV B, #10
        DIV AB               ; A=tens, B=ones
        MOV R1, A
        MOV R2, B

        ; Display hundreds if nonzero
        MOV A, R0
        JZ SKIP_HUND
        ADD A, #'0'
        LCALL WRITE_DATA
SKIP_HUND:

        ; Display tens if nonzero or hundreds shown
        MOV A, R1
        JZ SKIP_TENS
        ADD A, #'0'
        LCALL WRITE_DATA
SKIP_TENS:

        ; Display ones
        MOV A, R2
        ADD A, #'0'
        LCALL WRITE_DATA

        RET


; Subroutine: DISP_HEX
; Displays number in A as 2-digit hex
DISP_HEX:
        MOV R3, A
        ANL A, #0F0H
        SWAP A
        ACALL HEX_DIGIT
        MOV A, R3
        ANL A, #0FH
        ACALL HEX_DIGIT
        RET

; Convert nibble in A to ASCII and display
HEX_DIGIT:
        CJNE A, #0AH, NOT_HEX
        ADD A, #37H          ; 10->'A', 11->'B', ...
        SJMP DISP_CHAR
NOT_HEX:
        ADD A, #'0'
DISP_CHAR:
        LCALL WRITE_DATA
        RET


HERE:
        SJMP    HERE