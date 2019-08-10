; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/12/26/posicionamiento-y-movimiento-de-sprites/
; Prog31
;
; Programa para ejemplificar el diseño de sprites
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Sprite.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Constantes

puntero0 = $07f8
puntero1 = $07f9
puntero2 = $07fa
puntero3 = $07fb
puntero4 = $07fc
puntero5 = $07fd
puntero6 = $07fe
puntero7 = $07ff

activar = $d015

color0 = $d027
color1 = $d028
color2 = $d029
color3 = $d02a
color4 = $d02b
color5 = $d02c
color6 = $d02d
color7 = $d02e

posicionx0 = $d000
posiciony0 = $d001
posicionxmsb = $d010

;bloque = $0200
bloque = $3f80

; Programa

Prog31:
        jsr copiaSprite ; Copia los datos del sprite a la posición deseada

        lda #bloque/$40 ; Define el puntero para el sprite 0
        sta puntero0

        lda #%00000001  ; Activa el sprite 0
        sta activar

        lda #$0d        ; Fija el color para el sprite 0
        sta color0

        lda #183        ; Fija la posición X del sprite 0
        sta posicionx0

        lda #%00000000
        sta posicionxmsb

        lda #150        ; Fija la posición Y del sprite 0
        sta posiciony0

        rts

copiaSprite:

        ldx #$00

bucle:   lda spritePulga,x
        sta bloque,x

        inx

        cpx #$40

        bne bucle

        rts
