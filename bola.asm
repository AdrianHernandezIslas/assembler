.MODEL SMALL
include Libreria.lib;
.STACK 64;
.DATA
    letop1 DB 'Escribe Nombre: ','$'
    letop2 DB 'S','$'
    letop3 DB 'Apariciones: ','$'
    letoes DB 'Esta en i=','$'
    let DB 'Escribe caracter: ','$'
    v DB  30 DUP(?),'$'
    tamn DB ?,'$'
    x DB ?,'$'
    y DB ?,'$'
    num DB (0),'$'
    tope DW 0,'$'
    vocal DB ?,'$'
    CEN DB 0,'$'
    SEC DB 0,'$'
    V1 DB 0,'$'
    V2 DB 0,'$'
    V3 DB 0,'$'
    V4 DB 0,'$'
    COX DB 1,'$'
    COY DB 0,'$'
    salto DB 0DH,0AH,'$'
.CODE
MAIN PROC FAR
            MOV AX, @DATA
            MOV DS,AX
            CLEAR 0000,184FH
        
    aqui:   CALL TIEMPO

            CALL RANDOM
            CALL PELOTA 
            CMP COY,12
            JAE resta 
            ADD COY,30H
            OUTPUTCH COY
            JMP adios
    resta:  CALL RESTAR
            ADD COY,30H
            OUTPUTCH COY
    adios:  SALIR
MAIN ENDP
        
RESTAR PROC
        SUB COY,90
        RET
RESTAR ENDP

PELOTA PROC
        MARCA 11,COY,2FH
        ;MARCA 11,5,2FH
        ;MARCA 10,6,2FH
        ;MARCA 11,6,2FH
        ;MARCA 12,5,2FH
        ;MARCA 13,5,2FH
        ;MARCA 12,6,2FH
        ;MARCA 13,6,2FH
        RET
PELOTA ENDP

TIEMPO PROC
        MOV AH,2CH
        INT 21H
        MOV SEC,DH
        MOV CEN,DL
        MOV AL,CEN
        AAM
        OR AX,3030H
        MOV V1,AH
        MOV V2,AL
        AAM
        OR AX,3030H
        MOV V3,AH
        MOV V4,AL
        RET
TIEMPO ENDP

RANDOM PROC
        XOR AX,AX
        MOV AL,CEN
        ADD AL,V4
        MOV BL,18H
        DIV BL
        MOV COX,AH
        XOR AX,AX
        MOV AL,CEN
        ADD AL,V3
        MOV BL,4FH
        DIV BL
        MOV COY,AH
        RET
RANDOM ENDP

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