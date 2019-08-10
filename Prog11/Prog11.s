; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/19/instrucciones-de-escritura-de-datos/
; Prog11
;
; Este programa es para verificar los modos de direccionamiento
; soportados por las instrucciones sta, stx y sty
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog11:
        ; inicializaciones

        lda #$00
        ldx #$00
        ldy #$00

        ; sta

        sta $c100       ; Modo absoluto: soportado
        sta $c100,x     ; Modo absoluto indexado X: soportado
        sta $c100,y     ; Modo absoluto indexado Y: soportado
        sta $fb         ; Modo página cero: soportado
        sta $fb,x       ; Modo página cero indexado X: soportado
        sta $fb,y       ; El ensamblador lo convierte en sta $00fb,y
                        ; *** Comprobar en depurador ***
        sta ($fb),y     ; Modo indirecto indexado: soportado
        sta ($fb,x)     ; Modo indexado indirecto: soportado

        ; stx

        stx $c100       ; Modo absoluto: soportado
        stx $fb         ; Modo página cero: soportado
        stx $fb,y       ; Modo página cero indexado Y: soportado
                        ; El ensamblador NO lo convierte en stx $00fb,y
        ;stx $c100,y    ; Hay que comentarlo porque no ensambla

        ; sty

        sty $c100       ; Modo absoluto: soportado
        sty $fb         ; Modo página cero: soportado
        sty $fb,x       ; Modo página cero indexado X: soportado
                        ; El ensamblador NO lo convierte en sty $00fb,x
        ;sty $c100,x    ; Hay que comentarlo porque no ensambla

        rts
