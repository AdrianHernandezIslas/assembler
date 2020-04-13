TITLE
.286
pila SEGMENT STACK
	DB 32 DUP('stack---')
pila ENDS

datos SEGMENT 'DATA'
	v DB 5,4,2,1,3,'$'
	numero DB ?
datos ENDS

codigo SEGMENT 'CODE'
	ASSUME SS:pila, DS:datos, CS:codigo

	operacion PROC FAR

		PUSH DS
      	PUSH 0
        MOV AX,datos
        MOV ds,AX

		MOV CX,5
		MOV SI,0
evalua:	CMP v[SI],'3'
		JB 	suma
		ADD	SI,1
		CMP	SI,CX
		MOV AL,v[SI]
		ADD AL,30H
		MOV numero,AL
		LEA DX,numero
		MOV AH, 09H
      	INT 21H
		JB	evalua
		JMP	fin
suma: 	ADD v[SI],1
		ADD	SI,1
		CMP	SI,CX
		MOV AL,v[SI]
		ADD AL,30H
		MOV numero,AL
		LEA DX,numero
		MOV AH, 09H
      	INT 21H
		JB evalua
fin: 	RET
	operacion ENDP
codigo ENDS
END operacion
