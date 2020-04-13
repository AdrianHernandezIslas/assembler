TITLE
.286
PILA SEGMENT STACK
DB 32 DUP ('stack___')
PILA ENDS

DATOS SEGMENT 
letp DB 'Dame los numeros del Arreglo: ','$'
v DB  5 DUP(?),'$'
salto DB 0DH,0AH,'$'
numero  DB ?,'$'

DATOS  ENDS

CODIGO SEGMENT 'CODE'

ASSUME SS:PILA ,DS:DATOS, CS:CODIGO

principal PROC FAR
        PUSH DS
        PUSH 0 
        MOV AX, DATOS
        MOV ds,AX
;---------------------------------------------------       
 inteLe:LEA dx,letp;Mostrar un letrero en pantalla;
        MOV AH, 09H
        INT 21H
;---------------------------------------------------
        MOV SI,0  
 inte:  MOV AH,01H;interrupcion leer teclado
        INT 21H
        ADD AL,30H
        MOV v[SI],AL
        INC SI
        CMP SI,5
        JB inte
;---------------------------------------------------
        MOV SI,0
evalua: CMP SI,5;ciclo leer Arreglo
        JB suma
        JMP fin
suma:   CMP v[SI],3
        JB  cuenta
indice: MOV AL,v[SI]
        ADD AL,30H
        MOV numero,AL 
        LEA DX,numero 
        MOV AH,09H
        INT 21H
        ADD SI,1
        JMP evalua
cuenta: ADD v[SI],1
        JMP indice
fin:  RET

principal ENDP
CODIGO ENDS
END principal