; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/21/instrucciones-para-operaciones-aritmeticas-suma/
; Prog13
;
; Progama para ejemplificar la suma multibyte con adc
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Utils.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog13:
        ; Imprime la suma inicializada a cero

        ; (Esto se puede hacer de forma más compacta y sencilla
        ; con una macro, pero todavía no hemos llegado ahí :-( )

        jsr imprimeMem

        ; Suma los bytes LSB
        clc             ; Borra el acarreo anterior
        lda sum1Low     ; Carga el sumando 1, byte LSB
        adc sum2Low     ; Suma el sumando 2, byte LSB
        sta sumaLow     ; Pone la suma en suma, byte LSB

        ; Suma los bytes MSB

        ; *** OJO, ahora no se borra el acarreo ***

        lda sum1High    ; Carga el sumando 1, byte MSB
        adc sum2High    ; Suma el sumando 2, byte MSB
        sta sumaHigh    ; Pone la suma en suma, byte MSB

        ; Imprime la suma
        jsr imprimeMem

        rts             ; Vuelve a BASIC

; Variables

sum1Low:         .byte $ff
sum1High:        .byte $00

sum2Low:         .byte $ff
sum2High:        .byte $00

sumaLow:         .byte $00
sumaHigh:        .byte $00
