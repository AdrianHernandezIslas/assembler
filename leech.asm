TITLE
.286
PILA SEGMENT STACK
DB 32 DUP ('stack___')
PILA ENDS

DATOS SEGMENT 
leti DB 'Dame los numeros del Arreglo: ','$'
letp DB 'Dame el numero en la Posicion ','$'
v DB  5 DUP(?),'$'
salto DB 0DH,0AH,'$'
numero  DB ?,'$'

DATOS  ENDS

CODIGO SEGMENT 'CODE'

ASSUME SS:PILA ,DS:DATOS, CS:CODIGO

principal PROC FAR
;---------intrucciones de pila---------------------
        PUSH DS
        PUSH 0 
        MOV AX, DATOS
        MOV ds,AX
;--------Mostrar un letrero en pantalla-------------
        LEA DX,leti;
showle: MOV AH, 09H
        INT 21H
;-------este es le salto de linea---------------------
        LEA DX,salto
        MOV AH,09H
        INT 21H
;---------------------------------------------------
        MOV SI,0
 evalua:CMP SI,5
        JB  leech
        JMP fin
;-------INTERRUPCION LEE UN CARACTER CON ETIQUETA-------
leech:  LEA dx,letp;
        MOV AH, 09H;
        INT 21H;
        MOV DX,SI
        ADD DL,30H
        MOV AH,02H
        INT 21H
        MOV AH,01H
        INT 21H;lo que lee esta en AL
        ADD AL,30H
        MOV v[SI],AL
;-------este es le salto de linea---------------------
        LEA DX,salto
        MOV AH,09H
        INT 21H
;--------------------------------------------------
        INC SI
        JMP evalua
;-------------------------------------------------
fin:  RET

principal ENDP
CODIGO ENDS
END principal