.286
include gpe.lib

pila SEGMENT STACK
      DB 32 DUP('stack___')
pila ENDS

datos SEGMENT

   LETREROESC DB 'ESCRIBE CADENA: ','$'
     
   CADENAO DB 20 DUP(?),'$'
   CADENAD DB 20 DUP('.'),'$'
   
   ;COLORES DB 7D,ED,13H,6D,65H,4E,7B,6E,C6,BD,53H,EF,01H,4C,CC,A1,AA,6A,B9,21H,'$'
   
   index DB 0 , '$'

   LONGICO DB 0 ,'$'
   LONGICD DB 0 ,'$'

   aux DB 0,'$'

   x DB ?,'$'
   y DB ?,'$'

   letra DB ?,'$'

   debugger DB 'estoy aqui','$'

datos ENDS 


codigo SEGMENT 'CODE'
    ASSUME ss:pila, ds: datos,cs:codigo  
    
    
    Main PROC FAR
        push  ds
        push 0
        mov ax,datos
        mov ds,ax
        call menuPideCad
        ;OUTPUTCH LONGICO
                    SHOWMOUSE
            click:  
                    sub bx,bx
                    CLICKEDMOUSE
                    CMP BX,1
                    JE accion;
                    JMP click

           accion:  mov ah,0
                    mov al,0
                    call GETCOORXY
                    CMP y,4h
                    JNE salir
                    CMP x,20h
                    JNAE salir
                    MOV AH,20h
                    ADD AH,LONGICO
                    CMP x,AH
                    JNB salir;
                    ;imprimeYX 6h,20h,LOGICO
                    mueve 08h,20h
                    
                    ;imprime x
                    call guardarLetra
                    JMP click
           salir:   ret
    Main endp

        menuPideCad PROC
            call limpia
            imprimeYX 2h,20h,LETREROESC
            mueve 4h,20h
            LLENAARRAY CADENAO,LONGICO
            ret
        menuPideCad ENDP
                   
        guardarLetra PROC   
                CALL MOVEMOUSE


                sub si,si
                sub di,di
                MOV BH,0
                MOV BL,x
                SUB Bx,20H
    
                MOV SI,bx
                MOV AL,CADENAO[SI]
                MOV DI,SI
                mov letra,AL
                call buscaLetra
                ret
        guardarLetra ENDP

        buscaLetra PROC
                    MOV SI,0
                    MOV aux,0
                    MOV BH,0
            evab:   
                    CMP SI,20
                    JE  salirb
                    MOV BL,CADENAD[SI]
                    INC SI
                    CMP BL,letra
                    JNE evab 
                    MOV aux,SI
                    ADD aux,31 
                            
                    
                    JMP salirf

            salirb: MOV AL,letra
                    MOV CADENAD[DI],AL
                    call MOSTRARCADENA
            		
            salirf: 
            		ret
        buscaLetra ENDP


        GETCOORXY PROC
              MOV AX,CX;;mueve a ax, cx porque en cx esta la coordenada de x
              MOV BL,8H
              DIV BL
              MOV x,AL;AQUI TOY Guardando x;el resultado de una division siempre queda en AL
              MOV AX,DX
              DIV BL
              MOV y,AL ;AQUI TOY GUARDANDO y
              ret
        GETCOORXY ENDP

       MOVEMOUSE PROC
       		SUB CX,CX 
       		INC CX
       		SUB DX,DX
       		INC DX
       		SUB AX,AX
       		MOV AH,04H
       		INT 33H
 			MARCA x,4,2FH
       		MOV CX,1FH
       		MOV DX,00H
       		MOV AH,04H
       		;INT 33H
            RET
       MOVEMOUSE ENDP

       MOSTRARCADENA PROC
	            MOV CH,20H
	            MOV SI,0
	       for: CMP SI,20
	            JE  adiosm
	            CMP CADENAD[SI],'.'
	            JNE muestra
	    aumenta:INC SI
	            JMP for
	    muestra:
	            mueve 6h,CH
	            OUTPUTCH CADENAD[SI]
	            INC CH
	            JMP aumenta
	        adiosm:
	            ret
       MOSTRARCADENA ENDP

    codigo ENDS
    END Main 
    ;tenemos hasta el viernes para entregarlo
    ;el lunes son segundas de esta unidad
    ;proyecto a aprtir de mañaana
    ;dar salir sin que se tenga que teclear ninguna cadena