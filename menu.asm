.MODEL SMALL
include Libreria.lib;
.STACK 64;
.DATA
	letmenu DB '--Menu:--','$'
    letop1 DB '1.- Sumar','$'
    letop2 DB '2.- Restar','$'
    letop3 DB '3.- Nombre ','$'
    letop4 DB '4.- Salir','$'
    letop5 DB 'OPCION:','$'
    letA DB 'ESCRIBE A: ','$'
    letB DB 'ESCRIBE B: ','$'
    letR DB 'RESULTADO: ','$'
    v DB  25 DUP(?),'$'
    tamn DW ?,'$'
	salto DB 0DH,0AH,'$'
    num DB ?,"$"
.CODE
MAIN PROC FAR
	    MOV AX, @DATA
        MOV DS,AX
        SHOWMOUSE
  menu: CLEAR

        WRITEXY letmenu,3H,20H
        WRITEXY letop1,5H,20H
        WRITEXY letop2,7H,20H
        WRITEXY letop3,9H,20H
        WRITEXY letop4,0BH,20H
        WRITEXY letop5,0CH,29H
        
        GOTOXY 0CH,30H
        CALL INPUTCH
        CMP AL,34H
        JE fin
        CMP AL,31H
        JE suma
        CMP AL,32H
        JE resta
        CMP AL,33H
        JE pname
suma:   CALL SUMAR
        JMP MENU
resta:  CALL RESTAR 
        JMP MENU
pname:  CALL PEDIRNAME
        JMP MENU
fin:    MOV AH,04CH
        INT 21H

MAIN ENDP

SUMAR PROC
        CLEAR
        WRITEXY letmenu,3H,20H
        WRITEXY letA,5H,20H
        CALL INPUTCH
        MOV num,AL
        WRITEXY letB,7H,20H
        CALL INPUTCH
        ADD num,AL
        SUB num,30h ;restar esto antes de usar la macro
        WRITEXY letR,9H,20H;macro
        ESCRIBE num
        CALL INPUTCH
        RET
SUMAR ENDP

RESTAR PROC
pedir:  CLEAR
        WRITEXY letop2,3H,20H
        WRITEXY letA,5H,20H
        CALL INPUTCH
        MOV num,AL
        WRITEXY letB,7H,20H
        CALL INPUTCH
        CMP num,AL
        JB pedir
        SUB num,AL
        ADD num,30h ;restar esto antes de usar la macro
        WRITEXY letR,9H,20H;macro
        ESCRIBE num
        CALL INPUTCH;
        RET
RESTAR ENDP

PEDIRNAME PROC
        CLEAR
        WRITEXY letop3,3H,20H
        MOV SI,0
valora: CALL INPUTCH
        CMP AL,0DH ;Es enter
        JE rompe
        MOV v[SI],AL
        INC SI
        JMP valora
rompe:  MOV tamn,SI
        MOV SI,0
        ESCRIBE v[SI]
        CALL INPUTCH
        RET
PEDIRNAME ENDP


FINL PROC 
	LEA DX,salto
    MOV AH,09H
    INT 21H
    RET
FINL ENDP

END MAIN