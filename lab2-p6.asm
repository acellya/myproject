        ORG     0000H
        LJMP    MAIN

        ORG     0100H

NUM1    EQU     30H
NUM2    EQU     31H
BIN1    EQU     32H
BIN2    EQU     33H
RESULT  EQU     34H

MAIN:
        LCALL   LCD_CLR

        ; Example BCD inputs: 25 and 12
        MOV     NUM1, #25H
        MOV     NUM2, #12H

; Convert NUM1 from BCD to binary
        MOV     A, NUM1
        ANL     A, #0F0H      ; isolate tens
        SWAP    A
        MOV     R0, A         ; tens
        MOV     A, #10
        MUL     AB            ; R0*10
        MOV     R1, A         ; store tens*10
        MOV     A, NUM1
        ANL     A, #0FH       ; ones
        ADD     A, R1
        MOV     BIN1, A

; Convert NUM2 from BCD to binary
        MOV     A, NUM2
        ANL     A, #0F0H
        SWAP    A
        MOV     R0, A
        MOV     A, #10
        MUL     AB
        MOV     R1, A
        MOV     A, NUM2
        ANL     A, #0FH
        ADD     A, R1
        MOV     BIN2, A

; Multiply binary values
        MOV     A, BIN1
        MOV     B, BIN2
        MUL     AB            ; result in A(low), B(high)

; Convert result back to BCD
        MOV     B, #10
        DIV     AB            ; A = tens, B = ones
        SWAP    A
        ANL     A, #0F0H
        ORL     A, B
        MOV     RESULT, A

; Display result
        MOV     A, RESULT
        LCALL   WRITE_HEX

HERE:   SJMP    HERE
