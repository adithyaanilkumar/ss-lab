ASSUME DS:DATA,CS:CODE

DATA SEGMENT
MSG1 DB 0AH,0DH,"ENTER FIRST NUMBER:$"
MSG2 DB 0AH,0DH,"ENTER SECOND NUMBER:$"
MSG3 DB 0AH,0DH,"THE LCM IS:$"
DATA ENDS

CODE SEGMENT
START:
      MOV AX,DATA
      MOV DS,AX

      LEA DX,MSG1
      MOV AH,09H
      INT 21H
      MOV AH,01H;Input the first number.
      INT 21H
      MOV CL,AL
      SUB CL,30H
      MOV CH,CL


      LEA DX,MSG2
      MOV AH,09H
      INT 21H
      MOV AH,01H;Input the second number.
      INT 21H
      MOV BL,AL
      SUB BL,30H
      MOV BH,BL


L1: CMP CL,BL
    JE RESULT
    CMP CL,BL
    JL N1
    CMP CL,BL
    JG N2

N1: CALL PROCEDURE1
     JMP L1

N2: CALL PROCEDURE2
    JMP L1

RESULT: LEA DX,MSG3
        MOV AH,09H
        INT 21H
        MOV AL,BL
        MOV BL,0AH
        XOR AH,AH
        DIV BL
        ADD AX,3030H
        MOV BL,AL
        MOV CL,AH

        MOV DL,BL
        MOV AH,02H
        INT 21H

        MOV DL,CL
        MOV AH,02H
        INT 21H

        MOV AH,4CH
        INT 21H

PROCEDURE1 PROC
ADD CL,CH
RET
PROCEDURE1 ENDP

PROCEDURE2 PROC
ADD BL,BH
RET
PROCEDURE2 ENDP




CODE ENDS
END START