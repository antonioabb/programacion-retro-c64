; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/23/instrucciones-de-salto-condicional/
; Prog17
;
; Programa para ejemplificar el funcionamiento de las bifurcaciones
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Utils.s"
.include "FlagC.s"
.include "FlagZ.s"
.include "FlagV.s"
.include "FlagN.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog17:
        jsr flagZ
        jsr flagC
        jsr flagV
        jsr flagN
        rts
