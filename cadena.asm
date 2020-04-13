.MODEL SMALL
include Libreria.lib;
.STACK 64;
.DATA
    letop1 DB 'Escribe Cadena: ','$' 
    letop2 DB 'Dame el caracter a buscar: ','$'
    let DB 'Esta en i = ','$'
    letnota DB 'No esta en la cadena','$'
    cad1 DB 30 DUP (?),'$'
    cad2 DB (?),'$'
    v DB  30 DUP(?),'$'
    tamn EQU $-cad1
    x DB ?,'$'
    y DB ?,'$'
    tope DW 0,'$'
    tope2 DW 0,'$'
    vocal DB ?,'$'
    posc DW ?,'$'
    salto DB 0DH,0AH,'$'
.CODE
MAIN PROC FAR
    	    MOV AX, @DATA
            MOV DS,AX
            MOV ES,AX
            CLEAR 0000,184FH

            WRITEXY letop1,3H,20H 
            LLENACADENA cad1 
            ;ESCRIBE cad1
            MOV CX,tamn
            WRITEXY letop2,5H,20H
            CALL INPUTCH
            CLD
            LEA DI,cad1;LEE LA DIRRECION DONDE ESTA LA CADENA 
            REPNE SCASB
            JNE fin
            WRITEXY let,9H,20H
            LEA AX,cad1;QUITAR EL DESPLAZAMIENTO DONDE EMPEZO LA CADENA 
            SUB DI,AX
            ADD DI,30H
            MOV posc,DI
            ESCRIBE posc
            JMP adios
       fin: WRITEXY letnota,0BH,20H
     adios: SALIR

MAIN ENDP
        




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