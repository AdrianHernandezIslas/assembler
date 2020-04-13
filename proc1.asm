.MODEL SMALL;
include Libreria.LIB
.STACK 64;
.DATA 
      arre DB 5 DUP(?),'$' 
      salt DB 0AH,0DH,'$'
      let1 DB 'Arreglo:'
      tamlet = $-let1 
      let2 DB 'Dame el numero de la posicion ','$'
      let3 DB ' :  ','$'
      let4 DB 'El numero en la posicion ','$'
     
.CODE
   MAIN PROC FAR
     MOV AX, @DATA
     MOV DS,AX
     
     
        MOV SI,0
ciclo:  CMP SI,5 
        JAE imp
        CALL PEDIR
        ADD SI,1
        JMP ciclo 
         
        
imp:    MOV SI,0    
cicl:   CMP SI,5
        JAE fin
       ;codigo para salto de linea
        ESCRIBE salt    
        
       ;codigo para imprimir un caracter de teclado
        ESCRIBE let4
        
        MOV DX, SI  ;movemos a DX lo que hay en el registro SI
        ADD DL,30H  ;tomamos solo la parte baja de DX para que podamos mostrarla en pantalla
        CALL WRITECHAR
        
        ESCRIBE let3  ;imprime  ":  "
        
        MOV DL, arre[SI]  ;debemos mover a DL el caracter que queremos imprimir
        CALL WRITECHAR
        
        ADD SI,1
        JMP cicl      
fin:    .exit
     
MAIN ENDP;------------------------------------------------------------------------------
  
PEDIR PROC
      
        ;codigo para leer de teclado un caracter
        ESCRIBE let2 ; "Dame el numero de la posicion "
       
       
        MOV DX, SI  ;movemos a DX lo que hay en el registro SI
        ADD DL,30H  ;tomamos solo la parte baja de DX para que podamos mostrarla en pantalla
        CALL WRITECHAR 
        
        ESCRIBE let3 ;imprime  ":  "

        ;aqui se empieza a leer del teclado
        CALL READ
        MOV arre[SI],AL ; el valor del teclado se guarda en AL
        
        ;codigo para salto de puntero
        ESCRIBE salt  
        
        RET   
        
PEDIR ENDP

WRITE PROC
       MOV AH,09H
       INT 21H
       RET
WRITE ENDP


WRITECHAR PROC
       MOV AH,02H
       INT 21H
       RET
WRITECHAR ENDP

END MAIN