.MODEL SMALL;
include li.LIB
.STACK 64;
.DATA 
    nom1 DB 'NOMBRE: ', '$'
    nom2 DB 'ELIGE UNA VOCAL: ', '$'
    nom3 DB 'SALIR','$'
    nom4 DB 'REPETIR','$'
    vocal DB (0),'$'
    coor DW (0),'$'
    nombr DB 20 DUP(?),'$' 
    posic DW 20 DUP(?),'$'
    tamano DW (0),'$'
    coordx DB 0,'$'
    coordy DB 0,'$'
     
.CODE
   MAIN PROC FAR
     MOV AX, @DATA
     MOV DS,AX
     MOV ES,AX

nuevo:
     CLEAR 0000,184FH
     CALL PEDIRNOMBRE
     POSICION 11H,15H
     ESCRIBE nom4
     POSICION 11H,25H
     ESCRIBE nom3
mo:  SETMOUSE
     CMP BX,1
     JE coord
     JMP mo
     
coord:
     DIVNUM CX,8,coordx
     DIVNUM DX,8,coordy
     CMP coordy,11H
     JE val2
     JMP mo
val2:
     CMP coordx,15H
     JAE cmp1
     JMP mo
cmp1:
     CMP coordx,1BH
     JA cmp2
     JMP nuevo
cmp2:
     CMP coordx,25H
     JAE cmp3
     JMP mo
cmp3:
     CMP coordx,29H
     JA mo 
     JMP salir
     
     

salir:   MOV AH,04CH
         INT 21H
     
  MAIN ENDP
  
PEDIRNOMBRE PROC
      CLEAR 0000,184FH
      MOV CH,09H
      MOV CL, 1AH
     
      POSICION 9,18
      ESCRIBE nom1
      MOV SI,0
      MOV coor,CX
lee:  call READ
      CMP AL, 0DH
      JBE return
      MOV nombr[SI], AL
      INC SI
      JMP lee
      
return: 
       POSICION 0BH,15H
       ESCRIBE nom2
       POSICION 0DH,1BH
       MOV vocal,'a'
       ESCRIBECHAR vocal
       POSICION 0DH,1DH
       MOV vocal, 'e'
       ESCRIBECHAR vocal
       POSICION 0DH,1FH
       MOV vocal, 'i'
       ESCRIBECHAR vocal
       POSICION 0DH,21H
       MOV vocal, 'o'
       ESCRIBECHAR vocal
       POSICION 0DH,23H
       MOV vocal,'u'
       ESCRIBECHAR vocal
       mov tamano,SI  
mo2:   SETMOUSE
       CMP BX,1
       JE coord2
       JMP mo2
coord2:
       DIVNUM CX,8,coordx
       DIVNUM DX,8,coordy
       CMP coordy,0DH
       JE coord3
       JMP mo2
 otra: JMP return
coord3:CMP coordx,1BH
       JE  opa
       CMP coordx,1DH
       JE  ope
       CMP coordx,1FH
       JE  opi
       CMP coordx,21H
       JE  opo
       CMP coordx,23H
       JE  opu
       JMP mo2
   otraa: JMP otra
opa:   MOV vocal,'a'
       JMP validar
ope:   MOV vocal,'e'
       JMP validar
opi:   MOV vocal,'i'
       JMP validar
opo:   MOV vocal,'o'
       JMP validar
opu:   MOV vocal,'u'
validar: RETCOLOR 0000,2500
         POSICION 9,18
         ESCRIBE nom1
		 POSICION 9,26
  		 ESCRIBE nombr
  		 
        MOV SI,0
eva:    CMP SI, tamano
        JE otraa
        MOV BL, nombr[SI]
        CMP BL,vocal
        JE imprime
        INC SI
        JMP eva
imprime: 
         MOV CX,coor
         ADD CX,SI
         CLEARCOLOR CX,CX
         INC SI
         JMP eva 
 ; volve: POSICION 9,25
 ; 		 ESCRIBE nombr
 ; 		 JMP mo2
 fuera:  
         MOV SI,0
         RET
PEDIRNOMBRE ENDP
END MAIN