ASSUME CS:CODE,DS:DATA

DISPLAY MACRO MSG
LEA DX,MSG
MOV AH,09H
INT 21H
ENDM

DATA SEGMENT
MSG1 DB 0AH,"Enter the String:$"
MSG2 DB 0AH,0DH,"Converted String is:$"
STR DB 20 DUP("$")
LINE DB 10,13,("$")
DATA ENDS

CODE SEGMENT
START:	MOV AX,DATA
	MOV DS,AX
	
	DISPLAY MSG1

	MOV AH,0AH
	LEA DX,STR
	INT 21H

	MOV CH,00
	MOV CL,BYTE PTR[STR+1]
	LEA SI,STR+2
L1:	MOV AH,BYTE PTR[SI]
	CMP AH,"A"
	JL EXIT
	CMP AH,"Z"
	JG L2
	ADD BYTE PTR[SI],32
	JMP L3
L2:	CMP AH,"a"
	JL EXIT
	CMP AH,"z"
	JG EXIT
L3:	INC SI
	LOOP L1
	DISPLAY MSG2
	DISPLAY STR+2
EXIT:	MOV AH,4CH
	INT 21H
CODE ENDS
END START