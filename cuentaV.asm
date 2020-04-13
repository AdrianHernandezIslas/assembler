.MODEL SMALL
include Libreria.lib;
.STACK 64;
.DATA
    letop1 DB 'Escribe Nombre: ','$'
    letop2 DB 'S','$'
    letop3 DB 'Esta en i=','$'
    letA DB 'a','$'
    letE DB 'e','$'
    letI DB 'i','$'
    letO DB 'o','$'
    letU DB 'u','$'
    v DB  30 DUP(?),'$'
    tamn DW ?,'$'
    x DB ?,'$'
    y DB ?,'$'
    tope DW 0,'$'
    vocal DB ?,'$'
    salto DB 0DH,0AH,'$'
.CODE
MAIN PROC FAR
    	    MOV AX, @DATA
            MOV DS,AX
            CLEAR 0000,184FH
            WRITEXY letop1,3H,20H
            CALL PEDIRNAME
       menu:WRITEXY letA,5H,20H
            WRITEXY letE,5H,24H
            WRITEXY letI,5H,28H
            WRITEXY letO,5H,2CH
            WRITEXY letU,5H,30H
            WRITEXY letop2,5H,34H
      mouse:SHOWMOUSE   
    evaluac:CLICKEDMOUSE
            CMP BX,1
            JE accion
            JMP mouse
    accion: CALL GETCOORXY
            CMP y,5H
            JE evaluaX ; evaluaExtremoSuperior
            JMP mouse
    evaluaX:CMP x,20H
            JE isA
            CMP x,24H
            JE isE
            CMP x,28H
            JE isI
            CMP x,2CH
            JE isO
            CMP x,30H
            JE isU
            CMP x,34H
            JE fin
    saltar: JMP mouse
     isA:   MOV vocal,'a'
            CALL COUNTVOCAL
            JMP saltar
     isE:   MOV vocal,'e'
            CALL COUNTVOCAL
            JMP saltar
     isI:   MOV vocal,'i'
            CALL COUNTVOCAL
            JMP saltar
     isO:   MOV vocal,'o'
            CALL COUNTVOCAL
            JMP saltar
     isU:   MOV vocal,'u'
            CALL COUNTVOCAL
            JMP saltar 
            
    fin:    MOV AH,04CH
            INT 21H       


MAIN ENDP
        

COUNTVOCAL PROC
            GOTOXY 0BH,00H  
        eva:CMP SI,tope
            JE fuera
            MOV BL,v[SI]
            CMP BL,vocal
            JE imprime
            INC SI
            JMP eva
   imprime: ESCRIBE letop3
            MOV DX,SI
            ADD DL,30H
            MOV AH,02H
            INT 21H
            ESCRIBE salto
            INC SI
            JMP eva
    fuera:  MOV SI,0
            RET
COUNTVOCAL ENDP


PEDIRNAME PROC
        CLEAR 0000,184FH
        WRITEXY letop1,3H,20H
        MOV SI,0
valora: CALL INPUTCH
        CMP AL,0DH ;Es enter
        JE rompe
        MOV v[SI],AL
        INC SI
        ADD tope,1
        JMP valora
rompe:  MOV SI,0
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

END MAIN