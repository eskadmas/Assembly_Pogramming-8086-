; ESKADMAS AYENEW TEFERA

; JUNE 27, 2018 8086 

NCHAR EQU 20

.MODEL SMALL
.STACK
.DATA
    
    MSG1 DB "ENTER THE TEXT HERE: $"
    MSG2 DB 10, 13, "THE NUMBER OF LETTERS ARE: $"
    MSG3 DB 10, 13, "THE NUMBER OF DIGITS ARE: $"
    MSG4 DB 10, 13, "THE NUMBER OF SPACES ARE: $"
    
    PARAGRAPH DB NCHAR DUP (?)
    
    N_LETTERS DB 0
    N_DIGITS  DB 0
    N_SPACES  DB 0 
    REM       DB 0
    
.CODE
.STARTUP

    MOV AH, 9
    MOV DX, OFFSET MSG1
    INT 21H
    
    MOV DI, 0
    MOV CX, NCHAR 
    
    MOV AH, 1      

INPUT_CHARS: INT 21H

        CMP AL, 20H         ;SPACE IS 20H IN ASCII 
        JE SPACES
  
        CMP AL, 2CH         ;COMMA IS 2CH IN ASCII
        JE P_ARRAY
        
        CMP AL, 2EH         ;DOT IS 2EH IN ASCII
        JE P_ARRAY
        
        CMP AL, 3BH         ;SEMICOLON IS 3BH IN ASCII
        JE P_ARRAY 

        CMP AL, 30H         ;0 IS 30H IN ASCII
        JGE L1              ;IF AL >= 30H, THEN IT GOES TO L1 AND CHECKS IF AL <=39H
        JMP L2              ;OTHERWISE, IT JUMPS TO THE NEXT INSTRUCTION, I.E CHECKING THE LETTER CASE
        
    L1: 
        CMP AL, 39H         ;9 IS 39H IN ASCII
        JLE DIGITS          ;IF AL IS BETWEEN 30H AND 39H, THEN IT GOES TO DIGITS AND COUNTING THE NUMBERS  

    L2:
        CMP AL, 61H         ;CHAR 'a' IS 61H IN ASCII
        JGE L3                           
        JMP END_CASE        ;IF AN INPUT DOESN'T FULL FILL THE CASE OF THE PREVIOUS COMPARISONS, THE PROGRAM GOES TO AN END.
                            ;THIS ENABLES THE PROGRAM TO NOT ACCEPTINGS INPUTS OTHER THAN '.',';',',', DIGITS AND LOWER CASE LETTERS
    
    L3:
        CMP AL, 7AH                                                                                                  
        JLE LETTERS         ;THE PREVIOUS 2 COMPARISONS CHECK IF AL IS BETWEEN 61H AND 7AH, THEN THE PROGRAM GOES TO 'LETTERS' AND COUNTING THE LETTERS
        JMP END_CASE        ;IF AN INPUT DOESN'T FULL FILL THE CASE OF THE PREVIOUS COMPARISONS, THE PROGRAM GOES TO AN END.
                            ;THIS ENABLES THE PROGRAM TO NOT ACCEPTINGS INPUTS OTHER THAN '.',';',',', DIGITS AND LOWER CASE LETTERS 
        
    LETTERS:
    
       INC N_LETTERS        ;COUNTS THE NUMBER OF LETTERS IN THE INPUT TEXT
       JMP P_ARRAY
       
    DIGITS: 
    
       INC N_DIGITS         ;COUNTS THE NUMBER OF DIGITS IN THE INPUT TEXT
       JMP P_ARRAY
       
    SPACES:
    
        INC N_SPACES        ;COUNTS THE NUMBER OF SPACES IN THE INPUT TEXT        
                
    P_ARRAY:
        
        MOV PARAGRAPH[DI], AL   ;PUTS THE INPUT CHARACTER INTO AN ARRAY 
        
        INC DI
        DEC CX
        CMP CX, 0 
        
        JNZ INPUT_CHARS         ;JUMPS IF NCHAR IS NOT 0        
         
    MOV AH, 9
    MOV DX, OFFSET MSG2 
    INT 21H 
        
; CLEAR AH TO USE FOR A REMINDER
    
    MOV AH, 00    
    MOV AL, N_LETTERS 
    
    CALL DISPLAY            ;CALLS THE PROCEDURE HERE TO PRINT THE NUMBER OF LETTERS IN THE INPUT
    
    MOV AH, 9
    MOV DX, OFFSET MSG3 
    INT 21H 
        
; CLEAR AH TO USE FOR A REMINDER
    
    MOV AH, 00    
    MOV AL, N_DIGITS
    
    CALL DISPLAY            ;CALLS THE PROCEDURE HERE TO PRINT THE NUMBER OF DIGITS IN THE INPUT
    
    MOV AH, 9
    MOV DX, OFFSET MSG4 
    INT 21H 
        
; CLEAR AH TO USE FOR A REMINDER
    
    MOV AH, 00    
    MOV AL, N_SPACES 
    
    CALL DISPLAY            ;CALLS THE PROCEDURE HERE TO PRINT THE NUMBER OF SPACES IN THE INPUT
    
    JMP END_CASE
      
    PROC DISPLAY

    MOV BL, 10 
    
;AL/BL --> TWO DIGIT NUMBER/10 = DECIMAL VALUE
    
    DIV BL
    
;MOVE REMINDER TO REM
    MOV REM, AH 
 
    MOV DL, AL
    ADD DL,48
    MOV AH, 02H
    INT 21H

;TO PRINT THE REMINDER
    MOV DL, REM
    ADD DL, 48
    MOV AH, 02H
    INT 21H 
    
    RET 
    
    ENDP 

END_CASE:

    MOV AH, 4CH
    INT 21H 
    
    END    
              
    
    
     

