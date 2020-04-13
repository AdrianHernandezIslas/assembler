.MODEL SMALL
include Libreria.lib;
.STACK 64;
.DATA
	letmenu DB 'Menu ','$'
    letop1 DB '1.- Sumar','$'
    letop2 DB '2.- Restar','$'
    letop3 DB '3.- Nombre','$'
    letop4 DB '4.- Salir','$'
	;v DB  5 DUP(?),'$'
	salto DB 0DH,0AH,'$'
	numero  DB ?,'$'
.CODE
MAIN PROC FAR
	    MOV AX, @DATA
        MOV DS,AX

;--------Mostrar un letrero en pantalla-------------
        LIMPIA
        ESCRIBE letmenu
        CALL FINL
        ESCRIBE letop1
        CALL FINL
        ESCRIBE letop2
        CALL FINL
        ESCRIBE letop3
        CALL FINL
        ESCRIBE letop4

		

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