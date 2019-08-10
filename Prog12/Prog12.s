; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/19/instrucciones-de-transferencia-entre-registros/
; Prog12
;
; Programa para ejemplificar el uso de las instrucciones tax, txa, tay y tya
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Constantes

pantalla = $0400

Prog12:
        ; Inicializamos los 3 registros a $00
        lda #$00
        sta pantalla
        ldx #$00
        sta pantalla+1
        ldy #$00
        sta pantalla+2

        ; Alternativa que ocupa menos
        lda #$00
        sta pantalla+3
        tax             ; Ocupa 1 byte en vez de 2
        sta pantalla+4
        tay             ; Ocupa 1 byte en vez de 2
        sta pantalla+5

        ; Yo soy más partidario de la claridad que de la optimización
        ; pero hubo un tiempo en que ahorar cada byte era importante...

        ; Otro uso de txa y tya es para meter X e Y en la pila
        ; La única forma de hacerlo es con pha, que mete el acumulador
        ; en la pila, así que previamente hay que pasar por el
        ; acumulador con txa y tya

        rts
