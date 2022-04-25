 .model small
.stack 200H
.data
  msg1 DB 10,13,'Enter the limit::$'
  msg2 DB 10,13,'Enter the numbers::$'
  msg3 DB 10,13,'The numbers in ascending order is::$'
  comma DB ',$'
 newline DB 10,13,'$'
 count db ?
 tab1 db 20 dup(0)
.code
  printstring MACRO msg
 PUSH AX
 PUSH DX
 MOV AH,09H
 MOV DX,OFFSET msg
  INT 21H
 POP DX
 POP AX
 ENDM
start: printstring msg1
  CALL readnumtoAX
  MOV count,AL
  MOV CL,count
  MOV CH,00
  MOV BX,1
  printstring msg2
rdnxt:printstring newline
  CALL readnumtoAX
  MOV tab1[BX],AL
  INC BX
  LOOP rdnxt
  MOV CL,count
  MOV CH,00
  CMP CX,1
  JE DONE
  nextpass:
  MOV DL,00
  MOV BX,01
nextj:
  MOV AL,tab1[BX]
  MOV AH,tab1[BX + 1]
  CMP AL,AH
  JLE skip
  MOV tab1[BX],AH
  MOV tab1[BX + 1],AL
  MOV DL,1
skip:
  INC BX
  CMP BX,CX
  JL nextj
  DEC CX
  jz done
  CMP DL,01H
  JE nextpass
done:
  MOV CL,count
  MOV CH,00
  MOV BX,01
  printstring msg3
 prnnxt:
  MOV AX,00
  MOV AL,tab1[BX]
  CALL displayAX
  printstring comma
  INC BX
  LOOP prnnxt
  MOV AH,4CH
  MOV AL,00H
  INT 21H
readnumtoAX PROC NEAR
  PUSH BX
  PUSH CX
  MOV CX,10
  MOV BX,00
bac:
  MOV AH,01H
  INT 21H
  CMP AL,'0'
  JB skip1
  CMP AL,'9'
  JA skip1
  SUB AL,'0'
  PUSH AX
  MOV AX,BX
  MUL CX
  MOV BX,AX
  POP AX
  MOV AH,00
  ADD BX,AX
  JMP bac
skip1:
  MOV AX,BX
  POP CX
  POP BX
  RET
 readnumtoAX ENDP
displayAX PROC NEAR
  PUSH DX
  PUSH CX
  PUSH BX
  PUSH AX
  MOV CX,0
  MOV BX,10
 back1:
  MOV DX,0
  DIV BX
  PUSH DX
  INC CX
  OR AX,AX
  JNZ back1
back2:
  POP DX
  ADD DL,30H
  MOV AH,02H
  INT 21H
  LOOP back2
  POP AX
  POP BX
  POP CX
  POP DX
  RET
displayAX ENDP
END start
