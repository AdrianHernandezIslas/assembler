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
    tamC1 DW (?),'$';aqui sara guardado la cantidad de caracteres leidos de la cadena 1
    tamC2 DW (?),'$';"                                                              " 2
   
.CODE
MAIN PROC FAR
    	    MOV AX, @DATA
            MOV DS,AX
            MOV ES,AX
            CLEAR 0000,184FH;limpiamos la pantalla

            WRITEXY letop1,3,20; impresion de un letrero 
            LLENAARRAY cad1,tamC1; leectura de caracter por caracter 
            WRITEXY letop2,5,20 
            LLENAARRAY cad2,tamC2
            MOV SI,tamC1; copiar el tamaño de la cadena 1
            MOV DI,tamC2; "                           " 2
            CMP SI,DI; evaluar si la longitud de las cadenas es igual
            JE iguales
            JMP niguales
    iguales: MOV CX,tamC1; EL TAMAÑO DE LAS CADENAS
            LEA SI,cad1
            LEA DI,cad2
            REPE CMPSB
            JE yes
            JMP niguales
        yes:WRITEXY letE,7,20
            JMP adios
   niguales:WRITEXY letNE,7,20 
        
     adios: SALIR

MAIN ENDP
        

;LOOP ETIQUETA_CICLO
;CICLO MOV AX,1
      ;LOOP CICLO


END MAIN