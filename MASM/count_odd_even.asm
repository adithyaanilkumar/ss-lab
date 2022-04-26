DATA SEGMENT
    ARR DB 33H, 32H, 45H, 36H, 38H
    ODD DB 00H
    EVEN DB 00H
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    START: MOV AX, DATA
           MOV DS, AX
           
           LEA SI, ARR
           MOV CX, 05H
           MOV DL, 00H
           MOV DH, 00H
           
     BACK: MOV AL, [SI]
           ROR AL, 01H
           JC OCOUNT
           
           INC DL
           JMP NEXT
           
   OCOUNT: INC DH
           
     NEXT: INC SI
           LOOP BACK
           
           MOV ODD, DH
           MOV EVEN, DL
           
           MOV AH, 4CH
           INT 21H
CODE ENDS
END START