; ESKADMAS AYENEW TEFERA 

; JUNE 27, 2018 8086 

NCHAR EQU 20

.MODEL SMALL
.STACK
.DATA
    
    MSG1 DB "ENTER THE TEXT HERE: $"
    MSG2 DB 10, 13, "THE NUMBER OF LETTER 'a' IS: $"
    MSG3 DB 10, 13, "THE NUMBER OF LETTER 'e' IS: $"
    MSG4 DB 10, 13, "THE NUMBER OF LETTER 'i' IS: $"
    MSG5 DB 10, 13, "THE NUMBER OF LETTER 'o' IS: $"
    MSG6 DB 10, 13, "THE NUMBER OF LETTER 'u' IS: $"
    
    PARAGRAPH DB NCHAR DUP (?)
    
    N_a     DB 0
    N_e     DB 0
    N_i     DB 0
    N_o     DB 0
    N_u     DB 0
     
    REM     DB 0
    
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
        JE P_ARRAY
  
        CMP AL, 2CH         ;COMMA IS 2CH IN ASCII
        JE P_ARRAY
        
        CMP AL, 2EH         ;DOT IS 2EH IN ASCII
        JE P_ARRAY
        
        CMP AL, 3BH         ;SEMICOLON IS 3BH IN ASCII
        JE P_ARRAY 

        CMP AL, 30H         ;0 IS 30H IN ASCII
        JGE L1
        JMP L2
        
    L1: 
        CMP AL, 39H         ;9 IS 39H IN ASCII
        JLE P_ARRAY  

    L2:
        CMP AL, 61H
        JGE L3
        JMP END_CASE
    
    L3:
        CMP AL, 7AH
        JLE L_a
        JMP END_CASE 
        
    L_a:
    
        CMP AL, 61H
        JNE L_e 
        INC N_a
        JMP P_ARRAY
    
    L_e: 
    
        CMP AL, 65H
        JNE L_i 
        INC N_e
        JMP P_ARRAY
    
    L_i: 
    
        CMP AL, 69H
        JNE L_o 
        INC N_i
        JMP P_ARRAY
    
    L_o: 
    
        CMP AL, 6FH
        JNE L_u 
        INC N_o
        JMP P_ARRAY
    
    L_u: 
    
        CMP AL, 75H
        JNE P_ARRAY 
        INC N_u
        JMP P_ARRAY
        
    SPACES:
    
                
                
    P_ARRAY:
        
        MOV PARAGRAPH[DI], AL 
        
        INC DI
        DEC CX
        CMP CX, 0 
        
        JNZ INPUT_CHARS        
         
    MOV AH, 9
    MOV DX, OFFSET MSG2 
    INT 21H 
        
; CLEAR AH TO USE FOR A REMINDER
    
    MOV AH, 00    
    MOV AL, N_a 
    
    CALL DISPLAY
    
    MOV AH, 9
    MOV DX, OFFSET MSG3 
    INT 21H 
        
; CLEAR AH TO USE FOR A REMINDER
    
    MOV AH, 00    
    MOV AL, N_e
    
    CALL DISPLAY
    
    MOV AH, 9
    MOV DX, OFFSET MSG4 
    INT 21H 
        
; CLEAR AH TO USE FOR A REMINDER
    
    MOV AH, 00    
    MOV AL, N_i 
    
    CALL DISPLAY 
    
    MOV AH, 9
    MOV DX, OFFSET MSG5 
    INT 21H 
        
; CLEAR AH TO USE FOR A REMINDER
    
    MOV AH, 00    
    MOV AL, N_o 
    
    CALL DISPLAY 
    
    MOV AH, 9
    MOV DX, OFFSET MSG6 
    INT 21H 
        
; CLEAR AH TO USE FOR A REMINDER
    
    MOV AH, 00    
    MOV AL, N_u 
    
    CALL DISPLAY
    
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
              
    
    
     

