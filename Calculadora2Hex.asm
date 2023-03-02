printS MACRO string
    LEA DX,string
    MOV AH,09h
    INT 21h
ENDM
scan MACRO var
    MOV AH,01h
    INT 21h
    MOV var,AL
ENDM
.MODEL SMALL
.STACK
.DATA
    num1 db 0
    num2 db 0
    msg1 DB 'Escribe un numero: $'
    newLine DB 10,13,'$'
.CODE
PROGRAMA: ;Etiqueta de inicio del programa
    MOV AX,@data ;Para ubicar el segmento de datos y que
    MOV DS,AX    ;las variables se puedan acceder
    
    printS msg1
    scan num1  
    MOV AL,num1
    CALL ascii2hex
    MOV num1,AL
    ;##########################################################################
    ;Rutina de Cierre de Programa, devuelve el control a DOS
    MOV AH,4Ch
    INT 21h
    
    PROC ascii2hex ;Convierte un valor ascii a hexadecimal, el valor debe estar en AL
        CMP AL,39h
        JLE resta30
        JNLE resta38
        resta30:
            SUB AL,30h
            JMP retorno1
        resta38:
            SUB AL,38h
        retorno1:
            RET    
    ENDP
END

