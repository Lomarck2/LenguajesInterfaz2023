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
    
    ;MOV BX,0ABCDh
;    CALL imprimirRegistro
    
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
       SHR BX,12 ;Se coloca el digito mas a la izquierda en BL para poder imprimirlo
       MOV AL,BL
       CALL hex2ascii
       printC AL
       
       POP BX   ;Se coloca el segundo digito mas a la izquierda en BL para poder imprimirlo
       PUSH BX
       SHL BX,4
       SHR BX,12
       MOV AL,BL
       CALL hex2ascii
       printC AL
       
       POP BX   ;Se coloca el tercer digito mas a la izquierda en BL para poder imprimirlo
       PUSH BX
       SHL BX,8
       SHR BX,12
       MOV AL,BL
       CALL hex2ascii
       printC AL
       
       POP BX   ;Se coloca el cuarto digito mas a la izquierda en BL para poder imprimirlo
       PUSH BX
       SHL BX,12
       SHR BX,12
       MOV AL,BL
       CALL hex2ascii
       printC AL
       
       RET 
    ENDP
    
    PROC hex2ascii ;Convierte un valor ascii a hexadecimal, el valor debe estar en AL
        CMP AL,9h
        JLE suma30
        JNLE suma37
        suma30:
            ADD AL,30h
            JMP retorno1
        suma37:
            ADD AL,37h
        retorno2:                                          
        
            RET    
    ENDP
END

