        ORG     0000H
        LJMP    MAIN

        ORG     0100H

FIRST_DIGIT     EQU     30H ;equ makes constant 
SECOND_DIGIT    EQU     31H
SUM             EQU     32H

MAIN:
        LCALL   LCD_CLR

        ; read first digit
        LCALL   WAIT_KEY
        MOV     FIRST_DIGIT, A
        LCALL   WRITE_DATA

        ; print '+'
        MOV     A, #'+'
        LCALL   WRITE_DATA

        ; read second digit
        LCALL   WAIT_KEY
        MOV     SECOND_DIGIT, A
        LCALL   WRITE_DATA

        ; ASCII -> number (first)
        MOV     A, FIRST_DIGIT
        CLR     C
        SUBB    A, #'0'
        MOV     R0, A

        ; ASCII -> number (second)
        MOV     A, SECOND_DIGIT
        CLR     C
        SUBB    A, #'0'

        ; add
        ADD     A, R0

        ; number -> ASCII
        ADD     A, #'0'
        MOV     SUM, A

        ; '=' and result
        MOV     A, #'='
        LCALL   WRITE_DATA
        MOV     A, SUM
        LCALL   WRITE_DATA

HERE:
        SJMP    HERE

  
