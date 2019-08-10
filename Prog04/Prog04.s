; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/06/numeros-negativos/
; Prog04
;
; Este programa es para ejemplificar los números negativos
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Constantes

chrout  = $ffd2         ; rutina del Kernal para imprimir en pantalla

numero = %00100101      ; Número 37 en binario
comple = %11011010      ; Complemento a uno
contra = comple+1       ; Complemento a dos (-37)

Prog04:
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ; SUMA DE UN NÚMERO Y SU COMPLEMENTO  ;
        ; RESULTADO $FF                       ;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        lda #numero     ; carga el número
        jsr imprime     ; lo imprime

        lda #comple     ; carga el complemento
        jsr imprime     ; lo imprime

        cld             ; configura aritmética binaria
        clc             ; borra un posible acarreo previo
        adc #numero     ; suma el número y su complemento
        jsr imprime     ; imprime la suma; suma $ff

        lda #13         ; retorno de carro
        jsr chrout      ; imprime retorno de carro

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ; SUMA DE UN NÚMERO Y SU CONTRARIO    ;
        ; RESULTADO $00                       ;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        lda #numero     ; carga el número
        jsr imprime     ; lo imprime

        lda #contra     ; carga el contrario
        jsr imprime     ; lo imprime

        cld             ; configura aritmética binaria
        clc             ; borra un posible acarreo previo
        adc #numero     ; suma el número y su contrario
        jsr imprime     ; imprime la suma; suma $00

        lda #13         ; retorno de carro
        jsr chrout      ; imprime retorno de carro

        rts             ; vuelve a BASIC

; Subrutina que imprime el contenido del acumulador en binario

backup:  .byte $00
trabajo: .byte $00

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
