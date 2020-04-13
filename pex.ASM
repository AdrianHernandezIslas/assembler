.286
INCLUDE gpe.lib
pila SEGMENT STACK
      DB 32 DUP('stack___')

pila ENDS

datos SEGMENT

   MENSAJEERROR DB 'SIN CADENAS','$'
   LETRERO1 DB 'MENU','$'
   bandera DB '0','$'

   LETRERO2 DB '1.-LEER CADENA','$'
   LETREROC1 DB 'INGRESA LA CADENA UNO: ','$'
   LETREROC2 DB 'INGRESA LA CADENA DOS: ','$'

   LETRERO3 DB '2.-COMPARAR CADENA','$'
   letSonIgua DB 'Son Iguales','$'
   letNoSonIgua DB 'No Son Iguales','$'

   LETRERO4 DB  '3.-ESCANEAR CADENA','$'
   LETREROS DB 'ELIGE LA CADENA: ','$'
   LETREROEC DB 'CARACTER A BUSCAR: ','$'
   OPC1 DB '1.-  ','$'
   OPC2 DB '2.-  ','$'

   LETRERO5 DB '4.-SALIR','$'
   CADENA1 DB 20 DUP(?),'$'
   CADENA2 DB 20 DUP(?),'$'
   longitudCad1 DW ?,'$'
   longitudCad2 DW ?,'$'
   x DB ?,'$'
   y DB ?,'$'
   letra DB ?,'$'
   tamn DB ?,'$'
   opcion DB ?,'$'
   debug DB 'longitudDesigual','$'
   debugger DB 'caracteresDiferentes','$'

datos ENDS 


codigo SEGMENT 'CODE'
    ASSUME ss:pila, ds: datos,cs:codigo  
    
    
    Main PROC FAR
        push  ds
        push 0
        mov ax,datos
        mov ds,ax

menup:  call menuPrincipal
        SHOWMOUSE
click:  CLICKEDMOUSE
        CMP BX,1
        JE accion;
        JMP click
accion: call GETCOORXY
        CMP y,3H
        JNE evaluaOpc2
        CMP x,20H
        JNAE evaluaOpc2
        CMP x,2DH
        JNBE evaluaOpc2
        call menuLeer
        JMP menup
evaluaOpc2:
        ;CMP bandera,1
        ;JNE evaluaOpc4
        CMP y,4H
        JNE evaluaOpc3
        CMP x,20H
        JNAE evaluaOpc3
        CMP x,31H
        JNBE evaluaOpc3
        call menuCompara
        JMP menup
evaluaOpc3:
        CMP y,5H
        JNE evaluaOpc4
        CMP x,20H
        JNAE evaluaOpc4
        CMP x,31H
        JNBE evaluaOpc4
        call menuScanea
        JMP menup
evaluaOpc4:
        CMP y,6H
        JNE click
        CMP x,20H
        JNAE click
        CMP x,27H
        JNBE click
salir:  call limpia 
        ret
    Main endp

     menuPrincipal PROC
        call limpia
        mueve 2h,20h
        imprime LETRERO1
        mueve 3h,20h
        imprime LETRERO2
        mueve 4h,20H
        imprime LETRERO3
        mueve 5h,20H
        imprime LETRERO4
        mueve 6h,20H
        imprime LETRERO5
        ret
    menuPrincipal endp

    pideCadUno PROC
        call limpia
        imprimeYX 2h,20H,LETREROC1
        LLENAARRAY CADENA1,longitudCad1
        ret
    pideCadUno ENDP

    pideCadDos PROC
        imprimeYX 3h,20H,LETREROC2
        LLENAARRAY CADENA2,longitudCad2
        ret
    pideCadDos ENDP

    menuLeer PROC
        call pideCadUno
        call pideCadDos
        MOV bandera,1
        ret
    menuLeer endp

    compararCadenas PROC
                MOV SI,longitudCad1
                CMP SI,longitudCad2
                JNE nosonl
                
                MOV SI,0
        for:    MOV DH,CADENA1[SI]
                CMP DH,CADENA2[SI]
                JNE nosonc
                INC SI
                CMP SI,longitudCad1
                JB for
                imprimeYX 3h,20H,letSonIgua
                JMP termino
        nosonl: imprimeYX 3h,20H,debug
                JMP termino
        nosonc: imprimeYX 3h,20H,debugger
                
        termino:call INPUTCH
                ret
    compararCadenas endp

    menuCompara PROC
            CMP bandera,1
            JNE mensaje
            call limpia
            call compararCadenas
            JMP salirc
    mensaje:imprimeYX 08H,20H,MENSAJEERROR
            call INPUTCH
    salirc: ret
    menuCompara endp

    buscarCaracter PROC
                    mueve 2H,20H 
                    CMP opcion,1
                    JNE buscarCad2
                    BUSCARLETRA letra,CADENA1,longitudCad1 
                    imprime CADENA1
                    JMP fuera
        buscarCad2: BUSCARLETRA letra,CADENA2,longitudCad2 
                    imprime CADENA2
              fuera:call INPUTCH
                    ret
    buscarCaracter endp

    escanearCadena PROC
                call INPUTCH
                MOV opcion,AL
                call limpia
                sub opcion,30H
                CMP opcion,1
                JNE opcion2
                imprimeYX 2H,20H,CADENA1
                JMP pideLetra
        opcion2:CMP opcion,2
                JNE adios
                imprimeYX 2H,20H,CADENA2
      pideLetra:imprimeYX 4H,20H,LETREROEC
                call INPUTCH
                MOV letra,AL
                call buscarCaracter
        adios:  ret
    escanearCadena endp

    menuScanea PROC
                CMP bandera,1
                JNE mensaje2
                call limpia
                imprimeYX 2h,1DH,OPC1
                imprimeYX 2h,20H,CADENA1
                imprimeYX 3h,1DH,OPC2
                imprimeYX 3h,20H,CADENA2
                imprimeYX 4h,1DH,LETREROS
                call escanearCadena
                JMP salire
       mensaje2:imprimeYX 08H,20H,MENSAJEERROR
                call INPUTCH
       salire:  ret
    menuScanea endp

    menuSalir PROC
        call limpia
        ret
    menuSalir endp

    GETCOORXY PROC
        MOV AX,CX
        MOV BL,8H
        DIV BL
        MOV x,AL;AQUI TOY Guardando x
        MOV AX,DX
        DIV BL
        MOV y,AL ;AQUI TOY GUARDANDO y
        ret
    GETCOORXY ENDP

    codigo ENDS
    END Main 