.MODEL SMALL
include Libreria.lib;
.STACK 64;
.DATA
    letop1 DB 'Escribe Cadena 1: ','$'
    letop2 DB 'Escribe Cadena 2: ','$'
    letNE DB 'No son iguales','$'
    letE DB 'Son iguales','$'
    cad1 DB 30 DUP (?),'$'
    cad2 DB 30 DUP (?),'$'
    cont DW (?),'$'
    tamC1 DW (?),'$';aqui sara guardado la cantidad de caracteres leidos de la cadena 1
    tamC2 DW (?),'$';"                                                              " 2
    posc DW (?),'$'
.CODE
MAIN PROC FAR
    	    MOV AX, @DATA
            MOV DS,AX
            MOV ES,AX
            CLEAR 0000,184FH

            MOV posc,0
            MOV SI,0
            WRITEXY letop1,3,20; impresion de un letrero 
            LLENAARRAY cad1,tamC1; leectura de caracter por caracter 
            WRITEXY letop2,5,20 
            LLENAARRAY cad2,tamC2
            
            MOV CX,tamC1
otravez:    MOV AL,cad2[SI]
            CLD
            LEA DI,cad1;LEE LA DIRRECION DONDE ESTA LA CADENA
            ADD DI,posc
            REPNE SCASB
            JNE adios
            LEA AX,cad1;QUITAR EL DESPLAZAMIENTO DONDE EMPEZO LA CADENA 
            SUB DI,AX
            ADD DI,30H
            DEC DI
            MOV posc,DI
            ESCRIBE posc
            MOV SI,DI
            CMP SI,tamC1
            JB otra
            JMP adios
            
     adios: SALIR
MAIN ENDP
        

;LOOP ETIQUETA_CICLO
;CICLO MOV AX,1
      ;LOOP CICLO


END MAIN