; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/17/otros-modos-de-direccionamiento/
; Prog09
;
; Programa para ejemplificar el modo de direccionamiento indirecto
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Constantes

chrout = $ffd2 ; Rutina del Kernal para imprimir un carácter

Prog09:
        jmp m0          ; Modo absoluto; salta a "m0"

        lda #$31        ; No se llega a ejecutar por el salto directo
        sta $0400       ; No se llega a ejecutar por el salto directo
        rts             ; No se llega a ejecutar por el salto directo

m0:
        jmp (m1)        ; Modo indirecto; salta a la dirección
                        ; apuntada por m1 y m1+1, que es "m2"

        lda #$32        ; No se llega a ejecutar por el salto indirecto
        sta $0401       ; No se llega a ejecutar por el salto indirecto
        rts             ; No se llega a ejecutar por el salto indirecto

m1:
        .byte <m2,>m2    ; El operador < da el LSB y el > el MSB

m2:
        lda #$33        ; Sí se ejecuta por el salto indirecto
        sta $0402       ; Sí se ejecuta por el salto indirecto
        rts             ; Sí se ejecuta por el salto indirecto
