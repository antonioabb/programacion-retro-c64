; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/06/14/cia1-lectura-del-teclado/
; Prog55
;
; Programa para ejemplificar el uso del CIA1 para leer el teclado
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Mem.s"
.include "ConstIO.s"
.include "ConstText.s"
.include "LibIO.s"
.include "LibText.s"

; En CC65 no hace falta definir el cargador
; Cargador BASIC
; 10 SYS49152
; * = $0801
;   .byte    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00
; * = $c000 ; El programa se cargará en 49152

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE
Prog55:
        ; Configuración del CIA1
        jsr leeTecladoIOConf

bucle:
        ; Lee teclado
        jsr leeTecladoIO

        ; Imprime las coordenadas X,Y de la tecla pulsada
        jsr imprimeCoordenadas

        ; Imprime el carácter Petscii correspondiente a X,Y
        jsr imprimePetscii

        ; Vuelta a empezar
        jmp bucle

imprimeCoordenadas:

        ; Imprime la coordenada X de la tecla pulsada
        lda #<cadenaX
        sta cadenaLo
        lda #>cadenaX
        sta cadenaHi
        jsr pintaCadena

        lda coordX
        sta numeroHex
        jsr pintaHex

        lda #44 ; coma
        jsr chrout

        ; Imprime la coordenada Yde la tecla pulsada
        lda #<cadenaY
        sta cadenaLo
        lda #>cadenaY
        sta cadenaHi
        jsr pintaCadena

        lda coordY
        sta numeroHex
        jsr pintaHex

        lda #44 ; coma
        jsr chrout

        rts

cadenaX: .byte "x:"
        .byte 0

cadenaY: .byte "y:"
        .byte 0

imprimePetscii:

        lda coordX
        sta coordX2

        lda coordY
        sta coordY2

        jsr xy2Petscii

        lda petscii
        jsr chrout

        lda #13 ; retorno de carro
        jsr chrout

        rts
