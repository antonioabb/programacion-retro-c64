; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/25/instrucciones-de-desplazamiento-de-bits/
; https://programacion-retro-c64.blog/2018/12/13/rutinas-del-kernal/
; Prog18
;
; Programa para ejemplificar el uso de asl y lsr
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Utils.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog18:
        jsr leeAcum     ; Lee un byte del teclado
        jsr imprimeAcum ; Lo imprime por pantalla

        jmp Prog18      ; Continúa sin fin...
