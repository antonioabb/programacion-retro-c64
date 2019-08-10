; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/06/sistemas-de-numeracion/
; Prog02
;
; Este programa es para ejemplificar los sistemas de numeración
; Se verá cómo un mismo número puede representarse en decimal, bin y hex
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Constantes
deci = 37
bina = %00100101
hexa = $25

pantalla = $0400

Prog02:
        lda #deci       ; carga el número decimal
        sta pantalla    ; lo pone en la primera posición de pantalla

        lda #bina       ; carga el número binario
        sta pantalla+1  ; lo pone en la segunda posición de pantalla

        lda #hexa       ; carga el número hexadecimal
        sta pantalla+2  ; lo pone en la tercera posición de pantalla

        rts             ; vuelve a BASIC

; Se verá que en la pantalla se ve el mismo carácter 3 veces (%%%)
; Esto es así porque los números 37, %00100101 y $25 son el mismo
; Sólo hemos cambiado su forma de representación
