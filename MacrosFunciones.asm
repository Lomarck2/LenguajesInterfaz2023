imprimirLN MACRO
    MOV DL, 0Ah       ;ASCII para \n
    MOV AH, 02H       ;Se coloca 02h en AH 
    INT 21H           ;para llamar al servicio de terminal en
    MOV DL, 0Dh       ;ASCII para \r
    INT 21H           ;para llamar al servicio de terminal en      
ENDM  

imprimirC MACRO caracter
    MOV DL,caracter
    MOV AH,02H
    INT 21H
ENDM

.MODEL SMALL
.STACK
.DATA
    msj1 db 'Este programa$'
    msj2 db 'Emplea macros$'
    msj3 db 'muy bien$'
.CODE
PROGRAMA: ;Etiqueta de inicio del programa
    MOV AX,@data ;Para ubicar el segmento de datos y que
    MOV DS,AX    ;las variables se puedan acceder
    
    ;LEA DX,msj1
;    MOV AH,09h
;    INT 21h
;    
;    imprimirLN
;    LEA DX,msj2
;    MOV AH,09h
;    INT 21h 
;    
;    imprimirLN
;    LEA DX,msj3
;    MOV AH,09h
;    INT 21h
     MOV BL,0FFh
     CALL imprimir2Hex
    
    
    ;##########################################################################
    ;Rutina de Cierre de Programa, devuelve el control a DOS
    MOV AH,4Ch
    INT 21h
    
    PROC imprimirHex ;Procedimiento que imprime hexadecimales (0-9 A-F)
                     ;el hexadecimal debe estar en DL 
        CMP DL,09h
        JLE suma30
        JNE suma37
        suma30:
            ADD DL,30h
            JMP impr
        suma37:
            ADD DL,37h
        impr:
            MOV AH,02H
            INT 21H
    RET    
    ENDP 
    
    PROC imprimir2Hex
        PUSH BX        
        SHR BL,4
        MOV DL,BL
        CALL imprimirHex         
        POP BX
        SHL BX,12
        SHR BX,4
        MOV DL,BH
        CALL imprimirHex 
    RET
    ENDP
END

