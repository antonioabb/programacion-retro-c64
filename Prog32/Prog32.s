; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/12/28/sprites-multicolor/
; Prog32
;
; Programa para ejemplificar el diseño de sprites multicolor
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Sprites.s"

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

multicolor1 = $d025
multicolor2 = $d026
multicolor  = $d01c

negro = $00
rojo  = $02
amarillo = $07

; Programa

Prog32:
        jsr copiaSprite ; Copia los datos del sprite a la posición deseada

        lda #bloque/$40 ; Define el puntero para el sprite 0
        sta puntero0

        lda #%00000001  ; Activa el sprite 0
        sta activar

        lda #negro      ; Fija el color para el sprite 0
        sta color0

        lda #rojo       ; Fija el multicolor 1
        sta multicolor1

        lda #amarillo   ; Fija el multicolor 2
        sta multicolor2

        lda #%00000001  ; Activa el multicolor para el sprite 0
        sta multicolor

        lda #183        ; Fija la posición X del sprite 0
        sta posicionx0

        lda #%00000000
        sta posicionxmsb

        lda #150        ; Fija la posición Y del sprite 0
        sta posiciony0

        rts

copiaSprite:

        ldx #$00

bucle:  lda spritePulga,x
        sta bloque,x

        inx

        cpx #$40

        bne bucle

        rts
