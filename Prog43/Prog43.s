; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/02/12/mapas-o-pantallas-con-cbm-prg-studio/
; Prog43
;
; Programa para ejemplificar el diseño y uso de pantallas con CMB prg Studio
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Mem.s"
.include "ConstChars.s"
.include "Pantalla.s"
.include "LibChars.s"

; En CC65 no hace falta definir el cargador
; Cargador BASIC
; 10 SYS49152
; * = $0801
;   .byte    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00
; * = $c000 ; El programa se cargará en 49152

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog43:
        jsr borraPantalla
        jsr pintaPantalla
fin:     jmp fin

chrout = $ffd2

borraPantalla:

        lda #147
        jsr chrout
        rts

pintaPantalla:

        ldx #$0

        lda tablaPantallasLo,x
        sta cbComienzoLo

        lda tablaPantallasHi,x
        sta cbComienzoHi

        ; 1000 = $03e8

        lda tablaPantallasLo,x
        clc
        adc #$e8
        sta cbFinLo

        lda tablaPantallasHi,x
        adc #$03
        sta cbFinHi

        lda #<VICSCN
        sta cbDestinoLo

        lda #>VICSCN
        sta cbDestinoHi

        jsr copiaBloque

        rts

; Tabla de pantallas
; De momento sólo hay una, pero podría haber más

tablaPantallasLo:        .byte <pantalla1
tablaPantallasHi:        .byte >pantalla1
