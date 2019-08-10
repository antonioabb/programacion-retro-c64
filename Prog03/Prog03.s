; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/06/bcd-binary-coded-decimal/
; Prog03
;
; Este programa es para ejemplificar la diferencia entre la
; codificación binaria y la BCD. También la diferencia entre
; la artimética binaria y la aritmética BCD.
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Constantes

chrout  = $ffd2         ; rutina del Kernal para imprimir en pantalla

binSum1 = %00100101     ; %00100101=37
binSum2 = %00110111     ; %00110111=55

bcdSum1 = %00100101     ; %0010-0101=25
bcdSum2 = %00110111     ; %0011-0111=37

; Como se puede ver, la secuencia de bits que en binario representa
; 37 en BCD representa 25. Y la secuencia de bits que en binario
; representa 55 en BCD representa 37. Por tanto, las codificaciones
; son distintas.

; Además, se va a comprobar que para que la suma de números BCD sea
; correcta hay que activar el flag D. Si no, la suma es incorrecta.

Prog03:
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ; SUMA BINARIA CON OPERANDOS BINARIOS ;
        ; SUMA CORRECTA                       ;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        lda #binSum1    ; carga el sumando 1
        jsr imprime     ; lo imprime

        lda #binSum2    ; carga el sumando 2
        jsr imprime     ; lo imprime

        cld             ; configura aritmética binaria
        clc             ; borra un posible acarreo previo
        adc #binSum1    ; suma el sumando 1 al sumando 2
        jsr imprime     ; imprime la suma; suma correcta

        lda #13         ; retorno de carro
        jsr chrout      ; imprime retorno de carro

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ; SUMA BINARIA CON OPERANDOS BCD      ;
        ; SUMA INCORRECTA                     ;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        lda #bcdSum1    ; carga el sumando 1
        jsr imprime     ; lo imprime

        lda #bcdSum2    ; carga el sumando 2
        jsr imprime     ; lo imprime

        cld             ; configura aritmética binaria
        clc             ; borra un posible acarreo previo
        adc #bcdSum1    ; suma el sumando 1 al sumando 2
        jsr imprime     ; imprime la suma

        lda #13         ; retorno de carro
        jsr chrout      ; imprime retorno de carro; suma correcta

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ; SUMA BCD CON OPERANDOS BCD          ;
        ; SUMA CORRECTA                       ;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        lda #bcdSum1    ; carga el sumando 1
        jsr imprime     ; lo imprime

        lda #bcdSum2    ; carga el sumando 2
        jsr imprime     ; lo imprime

        sed             ; configura aritmética BCD
        clc             ; borra un posible acarreo previo
        adc #bcdSum1    ; suma el sumando 1 al sumando 2
        jsr imprime     ; imprime la suma

        lda #13         ; retorno de carro
        jsr chrout      ; imprime retorno de carro; suma correcta

        rts             ; vuelve a BASIC

; Subrutina que imprime el contenido del acumulador en binario

backup:   .byte $00
trabajo:  .byte $00

imprime:

        sta backup      ; resguarda el acumulador para recuperar
        sta trabajo     ; posición de trabajo
        ldx #8          ; el registro X va a recorrer los bits
bucle:  rol trabajo     ; pasa el bit 7 al acarreo
        lda #0          ; carga el acumulador con 0
        adc #$30        ; si no hay acarreo suma $30; si lo hay $31
        jsr chrout      ; imprime $30=0 o $31=1
        dex             ; pasa a la siguiente iteración / bit
        bne bucle       ; si no terminado, continúa
        lda #13         ; carga retorno de carro
        jsr chrout      ; imprime retorno de carro
        lda backup      ; recupera el valor original
        rts
