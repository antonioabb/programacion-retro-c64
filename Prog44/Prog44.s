; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/02/16/modo-bitmap-estandar/
; Prog44
;
; Programa para ejemplificar el modo bitmap
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Mem.s"
.include "LibBitmap.s"

; En CC65 no hace falta definir el cargador
; Cargador BASIC
; 10 SYS49152
; * = $0801
;   .byte    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00
; * = $c000 ; El programa se cargará en 49152

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog44:
        jsr rellenaBitmap
        jsr rellenaColor
        jsr configuraBitmap
fin:    jmp fin

configuraBitmap:

        lda #$01
        sta abBase

        jsr activaBitmap

        rts

rellenaColor:

        lda #%00010000  ; Blanco y negro
        sta rbByte

        lda #<VICSCN
        sta rbComienzoLo
        lda #>VICSCN
        sta rbComienzoHi

        lda #<$07e8
        sta rbFinLo
        lda #>$07e8
        sta rbFinHi

        jsr rellenaBloque

        rts

rellenaBitmap:

        lda #%00000001  ; Raya vertical de 1 pixel
        sta rbByte

        lda #<$2000
        sta rbComienzoLo
        lda #>$2000
        sta rbComienzoHi

        lda #<$4000
        sta rbFinLo
        lda #>$4000
        sta rbFinHi

        jsr rellenaBloque

        rts
