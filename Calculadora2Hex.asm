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

printC MACRO char
    MOV DL,char
    MOV AH,02H
    INT 21H
ENDM
.MODEL SMALL
.STACK
.DATA
    num1 db 0
    num2 db 0 
    temp db 0
    msg1 DB 'Escribe un numero: $'
    newLine DB 10,13,'$'
.CODE
PROGRAMA: ;Etiqueta de inicio del programa
    MOV AX,@data ;Para ubicar el segmento de datos y que
    MOV DS,AX    ;las variables se puedan acceder
    ;-------------------------------------------------------
    ;CAPTURA DE 2 DIGITOS HEXADECIMALES
    printS msg1
    scan temp  ;leer primer digito  
    MOV AL,temp
    CALL ascii2hex
    SHL AL,4
    MOV num1,AL
    
    scan temp  ;leer segundo digito 
    MOV AL,temp
    CALL ascii2hex
    ADD AL,num1
    MOV num1,AL  
    
    printS newLine
    ;-------------------------------------------------------
    ;CAPTURA DE 2 DIGITOS HEXADECIMALES
    printS msg1
    scan temp  ;leer primer digito  
    MOV AL,temp
    CALL ascii2hex
    SHL AL,4
    MOV num2,AL
    
    scan temp  ;leer segundo digito 
    MOV AL,temp
    CALL ascii2hex
    ADD AL,num2
    MOV num2,AL
    ;-------------------------------------------------------
    
    ;##########################################################################
    ;Rutina de Cierre de Programa, devuelve el control a DOS
    MOV AH,4Ch
    INT 21h
    
    PROC ascii2hex ;Convierte un valor ascii a hexadecimal, el valor debe estar en AL
        CMP AL,39h
        JLE resta30
        JNLE resta37
        resta30:
            SUB AL,30h
            JMP retorno1
        resta37:
            SUB AL,37h
        retorno1:                                          
        
            RET    
    ENDP 
    
    PROC imprimirRegistro ;Imprime los 4 digitos hexadecimales de registro BX
       PUSH BX
       SHR BX,12         ;Se coloca el digito mas a la izquierda en BL para poder imprimirlo
       MOV AL,BL
       CALL ascii2hex
       printC AL
       
       POP BX
       PUSH BX
       
        
    ENDP
END
