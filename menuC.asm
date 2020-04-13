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
    letF DB 'FUNCIONA!! ','$'
    v DB  25 DUP(?),'$'
    tamn DW ?,'$'
    x DB ?,'$'
    y DB ?,'$'
	salto DB 0DH,0AH,'$'
    num DB ?,"$"
.CODE
MAIN PROC FAR
    	    MOV AX, @DATA
            MOV DS,AX

      menu: CLEAR 0000,184FH

            WRITEXY letmenu,3H,20H
            WRITEXY letop1,5H,20H
            WRITEXY letop2,7H,20H
            WRITEXY letop3,9H,20H
            WRITEXY letop4,0BH,20H

    mouse:  SHOWMOUSE   
    evaluac:CLICKEDMOUSE
            CMP BX,1
            JE accion
            JMP mouse
    accion: CALL GETCOORXY
            CMP x,20H
            JAE evaluaESX ; evaluaExtremoSuperior
            JMP menu
  evaluaESX:CMP x,27H
            JBE evaluaY;aqui me quede
            JMP menu
  evaluaY:  CMP y,5H
            JE suma
            CMP y,7H
            JE resta
            CMP y,9H
            JE nombre
            CMP y,0BH
            JE fin
            JMP menu
    suma:   CALL SUMAR
            JMP menu
    resta:  CALL RESTAR
            JMP menu
    nombre: CALL PEDIRNAME
            JMP menu
    fin:    MOV AH,04CH
            INT 21H       


MAIN ENDP

SUMAR PROC
        CLEAR 0000,184FH
        ;WRITEXY letmenu,3H,20H
        WRITEXY letA,5H,21H
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
pedir:  CLEAR 0000,184FH
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
        CLEAR 0000,184FH
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

GETCOORXY PROC
        MOV AX,CX
        MOV BL,8
        DIV BL
        MOV x,AL;AQUI TOY Guardando x
        MOV AX,DX
        DIV BL
        MOV y,AL ;AQUI TOY GUARDANDO y
        RET
GETCOORXY ENDP

FINL PROC 
	LEA DX,salto
    MOV AH,09H
    INT 21H
    RET
FINL ENDP

END MAIN