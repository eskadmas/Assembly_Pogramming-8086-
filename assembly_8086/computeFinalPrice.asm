
;JANUARY 29, 2018 
;A PROGRAM TO COMPUTE FINAL PRICE AND TOTAL DISCOUNT
;TEFERA ESKADMAS AYENEW


PRODUCT EQU 5           ; THERE ARE 5 PRODUCT_CODES IN THE ARRAY

.MODEL SMALL
.STACK 
.DATA 

    MSG1 DB 10, 13, "Enter the Code of the 1st Product: $"
    MSG2 DB 10, 13, "Enter the Code of the 2nd Product: $"
    MSG3 DB 10, 13, "The Total Price of the Products is: $"
    MSG4 DB 10, 13, "The Final Price To_Be_Paid is: $"
    MSG5 DB 10, 13, "The Discount is: $" 
    MSG6 DB 10, 13, "The Percentage of Discount is: % $"

    OBJ_PRICES   DW 1500, 1300, 1200, 1100, 1000 
    
    PRODUCT_CODE DB PRODUCT DUP(?)          

    FULL_PRICE DW ?, "$"
    TO_BE_PAID DW ?, "$"
    DISCOUNT   DW ?, "$"
    PERCENTAGE DW ?, "$"
    TEMP1      DW ?, "$"
    TEMP2      DW ?, "$"
    TEMP3      DW ?, "$"

.CODE
.STARTUP 
    
    MOV AH, 9
    MOV DX, OFFSET MSG1     
    INT 21H
    
    MOV AH, 1 
    INT 21H  
    
    SUB AL, 30H                 ; THIS LINE OF INSTRUCTION IS USED TO CONVERT AN ASCII INTO DECIMAL NUMBER
    
    MOV SI, 0
    MOV PRODUCT_CODE[SI], AL    ; THE FIRST PRODUCT CODE THAT REFERS THE FIRST PRODUCT BOUGHT
    
    MOV AH, 9
    MOV DX, OFFSET MSG2
    INT 21H
    
    MOV AH, 1
    INT 21H
    
    SUB AL, 30H
    
    MOV PRODUCT_CODE[SI+1], AL     ; THE SECOND PRODUCT CODE THAT IS BOUGHT BY THE CUSTOMER 
    
    MOV AH, 9
    MOV DX, OFFSET MSG3
    INT 21H
   
    MOV AL, PRODUCT_CODE[SI]        ; THE FIRST PRODUCT CODE
    
    XOR CX, CX
    MOV CL, 2                        
    MUL CL                          ; SINCE THE PRICES ARE 16 BITS NUMBERS, EACH VALUE IS FOUND IN AN ADDRESS THAT IS MULTIPLE OF 2
    MOV AH, 00H
    MOV DI, AX                      ; AN INDEX TO ACCESS PRODUCT PRICES    

    MOV BX, OBJ_PRICES[DI]          ; THE FIRST PRODUCT PRICE
    MOV TEMP1, BX 
      
    MOV AL, PRODUCT_CODE[SI+1]      ; THE SECOND PRODUCT CODE
    XOR CX, CX
    MOV CL, 2 
    MUL CL
    MOV AH, 00H
    MOV DI, AX
    
    XOR DX, DX
    MOV DX, OBJ_PRICES[DI]          ; THE SECOND PRODUCT PRICE 
    MOV TEMP2, DX
    
    ADD BX, TEMP2                   ; IT IS TO ADD THE PRICES OF THE TWO PRODUCTS
    MOV FULL_PRICE, BX              ; MOVING THE SUM OF PRICES INTO A VARIABLE NAMED FULL_PRICE               
    
    MOV AX, FULL_PRICE 
    
    CALL SENI                       ; CALLING THE PROCEDURE HERE TO DISPLAY THE FULL PRICE OF THE PRODUCTS ON THE SCREEN
    
    MOV AH, 9
    MOV DX, OFFSET MSG4
    INT 21H
    
    MOV DI, 0
    
    MOV AX, TEMP1                   ; PRODUCT PRICE ONE
    MOV BX, TEMP2                   ; PRODUCT PRICE TWO 
    
    CMP AX, BX                      ; COMPARING TO IDENTIFY, WHICH ONE IS THE LEAST PRICE
    JA  L1                          ; JUMPS TO LABEL ONE IF AX IS GREATER THAN BX
    JBE L2                          ; JUMPS TO LABEL TWO IF AX IS LESS THAN BX
    
L1:
    SHR BX, 1                       ; A RIGHT SHIFT INSTRUCTION THAT IS USED TO DIVIDE BX BY 2
    ADD AX, BX                      ; ADDS THE RESULT (BX) OF THE PREVIOUSLY COMPUTED INSTRUCTION TO THE FULL PRICE (AX) 
    MOV TO_BE_PAID, AX              ; THE TO_BE_PAID PRICE
    
    CALL SENI                       ; CALLING THE PROCEDURE HERE TO DISPLAY THE TO_BE_PAID PRICE OF THE PRODUCTS ON THE SCREEN
    
    JMP L3                          ; JUMPS TO LABEL 3 
       
L2:
    SHR AX, 1                       ; A RIGHT SHIFT INSTRUCTION THAT IS USED TO DIVIDE AX BY 2
    ADD AX, BX                      ; ADDS THE FULL PRICE (BX) TO THE RESULT OF THE PREVIOUSLY COMPUTED INSTRUCTION (AX)
    MOV TO_BE_PAID, AX              ; MOVES THE COMPUTED RESULT TO A VARIABLE NAMED TO_BE_PAID 
    
    CALL SENI                       ; CALLING THE PROCEDURE HERE TO DISPLAY THE TO_BE_PAID PRICE OF THE PRODUCTS ON THE SCREEN

L3:   
    MOV AH, 9
    MOV DX, OFFSET MSG5
    INT 21H 
    
    MOV AX, FULL_PRICE              ; AX -> FULL_PRICE
    SUB AX, TO_BE_PAID              ; AX-> FULL_PRICE - TO_BE_PAID 
    
    MOV DISCOUNT, AX                ; DISCOUNT = FULL_PRICE - TO_BE_PAID 
    
    CALL SENI                       ; CALLING THE PROCEDURE HERE TO DISPLAY THE DISCOUNT PRICE OF THE PRODUCTS ON THE SCREEN
    
    MOV AH, 9
    MOV DX, OFFSET MSG6
    INT 21H
    
    XOR BX, BX
    XOR AX, AX
    
    MOV AX, DISCOUNT            
    MOV BX, 100
    
    MUL BX                      ; AX = DISCOUNT * 100
    MOV TEMP3, AX
    
    XOR AX, AX
    
    MOV AX, TEMP3               ; AX = DISCOUNT * 100
    DIV FULL_PRICE              ; AX = (DISCOUNT * 100) / FULL_PRICE
    
    MOV PERCENTAGE, AX          ; PERCENTAGE = (DISCOUNT * 100) / FULL_PRICE    
    
    CALL SENI                   ; CALLING THE PROCEDURE HERE TO DISPLAY THE RESULT OF PERCENTAGE ON THE SCREEN
     
    JMP END_P                   ; ENDS THE EXECUTIONS
    
SENI:
    XOR CX, CX
    MOV BX, 10

LP1:       
    XOR DX, DX
    DIV BX 
    PUSH DX
    INC CX
    TEST AX, AX                 ; TEST PERFORMS AN AND OPERATION OF THE DESTINATION WITH THE SOURCE BUT DOESN'T CHANGE DESTINATION
    JNZ LP1
LP2:
    POP DX
    ADD DL, 48
    MOV AH, 02H
    INT 21H
    LOOP LP2
    RET 2
    
END_P: 

    ENDP
     
    MOV AH, 4CH
    INT 21H 
      
    END      
    
        
