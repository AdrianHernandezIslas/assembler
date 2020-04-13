TITLE
.286
PILA SEGMENT STACK
DB 32 DUP ('stack___')
PILA ENDS

DATOS SEGMENT 
v DB  5 DUP(?)
numero  DB ?,'$'

DATOS  ENDS

CODIGO SEGMENT 'CODE'

ASSUME SS:PILA ,DS:DATOS, CS:CODIGO

principal PROC FAR
        PUSH DS
        PUSH 0 
        MOV AX, DATOS
        MOV ds,AX
             
        MOV SI,0
        MOV CX,5



 intep: MOV AH,01H;interrupcion leer teclado
        INT 21H
        ADD AL,30H
        MOV v[SI],AL
        ADD SI,1
        CMP SI,CX
        JB  intep
        MOV SI,0
intew:  MOV DL,v[SI];interrupcion imprir patalla valor por valor
        SUB DL,30H
        MOV AX,02H
        INT 21H
        ADD SI,1
        CMP SI,CX
        JB  intew
        JMP fin

evalua: CMP SI,5
        JB  suma
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