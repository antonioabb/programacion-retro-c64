; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/06/16/cia1-lectura-de-los-joysticks/
; Prog56
;
; Programa para ejemplificar el uso de los joysticks
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Mem.s"
.include "ConstJoy.s"
.include "ConstText.s"
.include "LibJoy.s"
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

Prog56:
        ; Lee el joystick1
        ; jsr leeJoystick1
        jsr leeJoystick2

        ; Pinta el joystick1
        ; jsr pintaJoystick1
        jsr pintaJoystick2

        jmp Prog56

; Rutina para pintar lo que se lee en el joystick1

pintaJoystick1:

        lda joy1

        sta numeroBin
        jsr pintaBin

        lda #13
        jsr chrout

        rts

pintaJoystick2:

        lda joy2

        sta numeroBin
        jsr pintaBin

        lda #13
        jsr chrout

        rts
