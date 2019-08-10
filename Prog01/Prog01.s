; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/10/programas-en-ensamblador-vs-programas-en-codigo-maquina/
; Prog01
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

pantalla = $0400 ; dirección de inicio de la RAM de pantalla

Prog01:
        ldx #$00        ; el registro X hace de índice
bucle:  lda cadena,x    ; carga el carácter X-esimo en el acumulador
        beq fin         ; si es 0, salta al final
        sta pantalla,x  ; si no es 0, pinta el carácter en pantalla
        inx             ; incrementa el índice X
        jmp bucle       ; vuelve al comienzo del bucle
fin:    rts             ; termina el programa, volviendo a BASIC

; cadena de texto a imprimir en pantalla
; consta de dos líneas y termina con el carácter cero

cadena: .byte "   PROGRAMACION RETRO DEL COMMODORE 64  "
        .byte "   ***********************************  "
        .byte $00
