.MODEL SMALL
include LibreriaMacros.lib
.STACK 64
.DATA
	leti DB 'Dame los numeros del Arreglo: ','$'
	letp DB 'Dame el numero en la Posicion ','$'
	v DB  5 DUP(?),'$'
	salto DB 0DH,0AH,'$'
	numero  DB ?,'$'
.CODE
MAIN PROC FAR
	 MOV AX, @DATA
     MOV DS,AX

;--------Mostrar un letrero en pantalla-------------
		ESCRIBE leti
;-------este es le salto de linea---------------------
        CALL FINL
;---------------------------------------------------
        MOV SI,0
 evalua:CMP SI,5
        JB  leech
        JMP fin
;-------INTERRUPCION LEE UN CARACTER CON ETIQUETA-------
leech:  LEA dx,letp;
        MOV AH, 09H;
        INT 21H;
;-------muestra LA POSICION DEL ARREGLO-----------------
        MOV DX,SI
        ADD DL,30H
        MOV AH,02H
        INT 21H
;---------------------------------------------------------
        CALL INPUTCH
        MOV v[SI],AL;MOVER EL RESULTADO QUE DEJA EL PROCEDIMIENTO 
;-------este es le salto de linea---------------------
        LEA DX,salto
        MOV AH,09H
        INT 21H
;--------------------------------------------------
        INC SI
        JMP evalua

fin:    MOV AH,04CH
        INT 21H

MAIN ENDP



FINL PROC 
	LEA DX,salto
    MOV AH,09H
    INT 21H
    RET
FINL ENDP

INPUTCH PROC
	 MOV AH,01H
     INT 21H;lo que lee esta en AL
     ADD AL,30H;DESPUES DE ESTE PROCEDIMIENTO EL RESULTADO ESTA EN AL
     RET
INPUTCH ENDP


END MAIN