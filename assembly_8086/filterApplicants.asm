
;FEBRUARY 26, 2018 
;A PROGRAM TO FILTER SCHOLARSHIP APPLICANTS BY THE SCHOLARSHIP COMMITTEE
;TEFERA ESKADMAS AYENEW 

APPLICANT       EQU     2
PASSED_EXAMS    EQU     2 
RECORDS         EQU     4

.MODEL SMALL
.STACK
.DATA 
    MSG_A DB "STUDENT 1 RECORDS: $"
    MSG_B DB 10, 13, "STUDENT 2 RECORDS: $"
    MSG1 DB 10, 13, "Enter the Credit of the 1st Exam: $"
    MSG2 DB 10, 13, "Enter the Credit of the 2nd Exam: $"
    MSG3 DB 10, 13, "Enter the 1st Score of the Student: $"
    MSG4 DB 10, 13, "Enter the 2nd Score of the Student: $"
  
    MSG5 DB 10, 13, "The Total Sum of Credits is: $"
    MSG6 DB 10, 13, "The Total Sum of Scores is: $" 
    MSG7 DB 10, 13, "The Sum is: $"
    MSG8 DB 10, 13, "The Student with the Largest Sum is: ID. $" 
   
    APPLICATIONS DB APPLICANT DUP (?)
    ID DB 201, 202
    
    EXAM_CREDITS DB RECORDS DUP (?)
    EXAM_SCORES DB RECORDS DUP (?)  
    
    SUM_OF_CREDITS DB APPLICANT DUP (?)
    SUM_OF_SCORES DB APPLICANT DUP (?)
    SUM DB APPLICANT DUP (?) 
    LARGEST DB ?
    NUM DB 10
    NUM1 DB ?
    NUM2 DB ?
    TEMP DB ?

.CODE
.STARTUP

    MOV DI, 0
    
;ENTER EXAM_CREDITS AS INPUT AND COMPUTING THE SUM_OF_CREDITS FOR THE 1ST STUDENT
    
    MOV AH, 9
    MOV DX, OFFSET MSG_A     
    INT 21H
    
    MOV AH, 9
    MOV DX, OFFSET MSG1     
    INT 21H   
    
    MOV AH, 1
    INT 21H    
    SUB AL, 30H                 ; THIS LINE OF INSTRUCTION IS USED TO CONVERT AN ASCII INTO DECIMAL NUMBER 
    
    CMP AL, 4
    JNE FINAL 
    
    MOV EXAM_CREDITS[DI], AL
    
    MOV AH, 9
    MOV DX, OFFSET MSG2     
    INT 21H
    
    MOV AH, 1  
    INT 21H
    SUB AL, 30H                 ; THIS LINE OF INSTRUCTION IS USED TO CONVERT AN ASCII INTO DECIMAL NUMBER  
    
    CMP AL, 4
    JNE FINAL 
    
    ADD EXAM_CREDITS[DI], AL
    
    MOV BL, EXAM_CREDITS[DI] 
    MOV SUM_OF_CREDITS[DI], BL      ; SUM OF CREDITS FOR THE 1ST STUDENT 
    
    MOV AH, 9
    MOV DX, OFFSET MSG5     
    INT 21H
    
    MOV AL, SUM_OF_CREDITS[DI]    
    XOR AH, AH    
    CALL SENI

    
;ENTER EXAM_SCORES AS INPUT AND COMPUTING THE SUM_OF_SCORES FOR THE 1ST STUDENT   
     
    
    MOV DX, OFFSET MSG3
    MOV AH, 9
    INT 21H
    
    CALL READ
    
    CMP AL, 18
    JL FINAL
    CMP AL, 31
    JA FINAL
    
    MOV EXAM_SCORES[DI], AL 
    
    MOV DX, OFFSET MSG4
    MOV AH, 9
    INT 21H
    
    CALL READ
    
    CMP AL, 18
    JL FINAL
    CMP AL, 31
    JA FINAL  
        
    ADD EXAM_SCORES[DI], AL
    
    MOV BL, EXAM_SCORES[DI] 
    MOV SUM_OF_SCORES[DI], BL   ; SUM OF SCORES FOR THE 1ST STUDENT 
    
    MOV AH, 9
    MOV DX, OFFSET MSG6     
    INT 21H 
        
    MOV AL, SUM_OF_SCORES[DI]    
    XOR AH, AH    
    CALL SENI 
    
; THE FOLLOWING IS TO COMPUTE THE SUM FOR THE 1ST STUDENT

    MOV AL, SUM_OF_SCORES[DI]
    SHL AL, 2
    MOV SUM[DI], AL
    
    MOV AH, 9
    MOV DX, OFFSET MSG7     
    INT 21H
    
    MOV AL, SUM[DI]
    XOR AH, AH    
    CALL SENI
        
 
;ENTER EXAM_CREDITS AS INPUT AND COMPUTING THE SUM_OF_CREDITS FOR THE 2ND STUDENT
    
    MOV AH, 9
    MOV DX, OFFSET MSG_B     
    INT 21H
    
    MOV AH, 9
    MOV DX, OFFSET MSG1     
    INT 21H   
    
    MOV AH, 1
    INT 21H    
    SUB AL, 30H                 ; THIS LINE OF INSTRUCTION IS USED TO CONVERT AN ASCII INTO DECIMAL NUMBER
    
    CMP AL, 4
    JNE FINAL
    
    MOV EXAM_CREDITS[DI+1], AL
    
    MOV AH, 9
    MOV DX, OFFSET MSG2     
    INT 21H
    
    MOV AH, 1  
    INT 21H    
    SUB AL, 30H                 ; THIS LINE OF INSTRUCTION IS USED TO CONVERT AN ASCII INTO DECIMAL NUMBER 
    
    CMP AL, 4
    JNE FINAL
     
    ADD EXAM_CREDITS[DI+1], AL
    
    MOV BL, EXAM_CREDITS[DI+1] 
    MOV SUM_OF_CREDITS[DI+1], BL  ; SUM OF CREDITS FOR THE 2ND STUDENT 
    
    MOV AH, 9
    MOV DX, OFFSET MSG5     
    INT 21H
    
    MOV AL, SUM_OF_CREDITS[DI+1]    
    XOR AH, AH    
    CALL SENI 

;ENTER EXAM_SCORES AS INPUT AND COMPUTING THE SUM_OF_SCORES FOR THE 2ND STUDENT   
    
    MOV DX, OFFSET MSG3
    MOV AH, 9
    INT 21H
    
    CALL READ
    
    CMP AL, 18
    JL FINAL
    CMP AL, 31
    JA FINAL
    
    MOV EXAM_SCORES[DI+1], AL
    
    MOV DX, OFFSET MSG4
    MOV AH, 9
    INT 21H
    
    CALL READ
    
    CMP AL, 18
    JL FINAL
    CMP AL, 31
    JA FINAL
      
    ADD EXAM_SCORES[DI+1], AL
    
    MOV BL, EXAM_SCORES[DI+1] 
    MOV SUM_OF_SCORES[DI+1], BL     ; SUM OF SCORES FOR THE 2ND STUDENT
    
    MOV AH, 9
    MOV DX, OFFSET MSG6     
    INT 21H 
    
    MOV AL, SUM_OF_SCORES[DI+1]
    XOR AH, AH    
    CALL SENI 
    
; THE FOLLOWING IS TO COMPUTE THE SUM FOR THE 2ND STUDENT  

    MOV AL, SUM_OF_SCORES[DI+1]
    SHL AL, 2 
    MOV SUM[DI+1], AL
    
    MOV AH, 9
    MOV DX, OFFSET MSG7     
    INT 21H
    
    MOV AL, SUM[DI+1]    
    XOR AH, AH    
    CALL SENI

;COMPARING SUM1 AND SUM2 TO FIND THE LARGEST ONE
 
    MOV BL, SUM[DI]
    MOV CL, SUM[DI+1]
    
    CMP BL, CL
    JA L1
    MOV LARGEST, CL 
    
    MOV AH, 9
    MOV DX, OFFSET MSG8     
    INT 21H
    
    MOV AL, ID[DI+1]
    XOR AH, AH
    CALL SENI
    JMP FINAL
L1:
    MOV LARGEST, BL
    
    MOV AH, 9
    MOV DX, OFFSET MSG8     
    INT 21H
     
    MOV AL, ID[DI]
    XOR AH, AH
    CALL SENI
    JMP FINAL

; A PROCEDURE TO ENTER NUMBERS BETWEEN 18 AND 31

PROC READ 
       
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV NUM1, AL 
    
    MOV AH, 1
    INT 21H
    SUB AL, 48
    MOV NUM2, AL 
     
    MOV AL, NUM1
    MOV AL, NUM1
    MUL NUM
    ADD AL, NUM2
         
    MOV TEMP, AL

    RET
    ENDP  

; A PROCEDURE TO PRINT THE OUTPUT

SENI:
    XOR CX, CX                  ; CX = 0, WHICH IS USED TO PUT THE NUMBER OF DIGITS
    MOV BX, 10                  ; THE DIVISOR

LP1:       
    XOR DX, DX                  ; CLEAR DX FOR THE NEXT DIV
    DIV BX                      ; DX:AX / BX = AX REMAINDER: DX  
    PUSH DX                     ; LIFO
    INC CX                      ; INCREMENT NUMBER OF DIGITS
    TEST AX, AX                 ; CHECKS WHETHER AX = 0 OR NOT
    JNZ LP1                     ; NO: ONCE MORE
LP2:
    POP DX                      ; GET BACK PUSHED DIGIT
    ADD DL, 48                  ; THIS INSTRUCTION IS USED TO CONVERT EACH DIGIT TO DECIMAL
    
    MOV AH, 02H                                  
    INT 21H                     ; TO DISPLAY 
    LOOP LP2                    ; EACH POPED DIGIT
    RET 2                       ; TO RETURN THE NEXT TASK
    
END_P: 

    ENDP                        ; END OF THE PROCEDURE
   
    
FINAL:  

    .EXIT
    END 
