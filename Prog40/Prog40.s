; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/02/09/juegos-de-caracteres-personalizados/
; Prog40
;
; Programa para ejemplificar el uso de juegos de caracteres personalizados
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Mem.s"
.include "Chars.s"

.include "LibChars.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Por defecto el VIC direcciona el banco 0: $0000 - $3fff

; Dentro de este banco, los bloques de 2K son:
; - $0000 - $07ff
; - $0800 - $0fff
; - $1000 - $17ff
; - $1800 - $1fff
; - $2000 - $17ff
; - $2800 - $2fff
; - $3000 - $37ff
; - $3800 - $3fff ==> vamos a usar este, que es el 111


Prog40:
        jsr copiaCaracteres
        jsr configuraVic
        rts

copiaCaracteres:

        lda #<comienzoCars
        sta cbComienzoLo

        lda #>comienzoCars
        sta cbComienzoHi

        lda #<finCars
        sta cbFinLo

        lda #>finCars
        sta cbFinHi

        lda #$00
        sta cbDestinoLo

        lda #$38
        sta cbDestinoHi

        jsr copiaBloque
        rts

configuraVic:

        lda #%00000111
        sta acJuego

        jsr activaCars
        rts
