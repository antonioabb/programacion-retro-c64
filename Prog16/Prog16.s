; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/23/instrucciones-para-operaciones-logicas/
; Prog16
;
; Programa para ejemplificar el uso de las instrucciones lógicas
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Utils.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Constantes

valorAnd = %11111111
maskAnd  = %01010101 ; Los 0 marcan los bits que se pondrán a 0

valorOr  = %00000000
maskOr   = %01010101 ; Los 1 marcan los bits que se pondrán a 1

valorEor = %11111111
maskEor  = %01010101 ; Los 1 marcan los bits que cambiarán

valorNot = %10101010
maskNot  = %11111111 ; Todos los bits cambiarán

Prog16:
        ; And
        lda #valorAnd
        jsr imprimeAcum
        and #maskAnd
        jsr imprimeAcum

        ; Or
        lda #valorOr
        jsr imprimeAcum
        ora #maskOr
        jsr imprimeAcum

        ; Eor
        lda #valorEor
        jsr imprimeAcum
        eor #maskEor
        jsr imprimeAcum

        ; Not
        lda #valorNot
        jsr imprimeAcum
        eor #maskNot
        jsr imprimeAcum

        rts
