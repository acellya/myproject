        ORG     0000H
        LJMP    MAIN

        ORG     0100H

FIRST_DIGIT     EQU     30H
SECOND_DIGIT    EQU     31H
DIFF            EQU     32H

MAIN:
        LCALL   LCD_CLR

        ; read first digit
        LCALL   WAIT_KEY
        MOV     FIRST_DIGIT, A
        LCALL   WRITE_DATA

        ; print '-'
        MOV     A, #'-'
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
        MOV     R1, A

        ; subtraction: R0 - R1
        MOV     A, R0
        CLR     C
        SUBB    A, R1
        MOV     DIFF, A

        ; '=' 
        MOV     A, #'='
        LCALL   WRITE_DATA

        ; checking
        JNC POSITIVE_RESULT ;jump if no carry 
NEGATIVE_RESULT:
        ; print '-' and show |R0-R1|
        MOV     A, #'-'
        LCALL   WRITE_DATA

        MOV     A, R1
        CLR     C
        SUBB    A, R0            ; |R0-R1| = R1-R0
        ADD     A, #'0'          ; to ASCII
        LCALL   WRITE_DATA
        SJMP    DONE

POSITIVE_RESULT:
        MOV     A, DIFF          ; R0-R1 (expect 0..9)
        ADD     A, #'0'          ; to ASCII
        LCALL   WRITE_DATA
DONE:
        SJMP    $   