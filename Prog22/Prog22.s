; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/12/09/subrutinas-vs-macros/
; Prog22
;
; Programa para comparar subrutinas y macros
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Prog22b.s"
.include "Prog22c.s"
.include "Prog22d.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog22:
        lda #$01                        ; Carácter a pintar
        sta char
        jsr pintaPantalla               ; Llama a la subrutina

        rts                             ; Vuelve a BASIC

; Esta subrutina pinta una carácter X en la posición de pantalla $0400
; El carácter X se pasa en la posición char

char:    .byte $00

pintaPantalla:

        lda char
        sta $0400

        rts
