; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/17/otros-modos-de-direccionamiento-derivados-de-los-basicos/
; https://programacion-retro-c64.blog/2018/11/25/bucles/
; Prog08
;
; Programa para ejemplificar el modo de direccionamiento indexado
; Borra la RAM de pantalla.
;
; La RAM de pantalla ocupa 1000 posiciones, desde la $0400 hasta la
; $07e7, ambas incluidas. 1000 posiciones no se pueden recorrer con
; un sólo índice X o Y. Por ello, se hacen 4 segmentos de 250.

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Constantes

pantalla = $0400
segmento = 250

espacio = 32

Prog08:
        ldx #$00        ; Carga el índice con 0
        lda #espacio    ; Carga el acumulador con el código del espacio

bucle:  sta $0400,x     ; Modo indexado
        sta $0400+250,x ; La suma $0400+250 la hace el ensamblador
        sta $0400+500,x
        sta $0400+750,x

        inx             ; Incrementa el índice
        cpx #segmento   ; Modo inmediato

        bne bucle       ; Si X no ha llegado a 250, vuelve

        rts             ; Vuelve a BASIC
