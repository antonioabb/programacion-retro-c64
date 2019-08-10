; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/17/los-modos-de-direccionamiento-basicos/
; Prog07
;
; Programa para ejemplificar los modos de direccionamiento
; inmediato y absoluto
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

pantalla = $0400

Prog07:
        lda #$00        ; modo inmediato; se carga el valor $00 en A
        sta pantalla    ; imprime A ($00) en pantalla

        lda $00         ; modo absoluto; en realidad página cero
                        ; carga el valor almacenado en la dir $00
                        ; en el acumulador
        sta pantalla+1  ; imprime A (valor de la pos. $00) en pantalla

                        ; como se podrá observar, no es lo mismo
                        ; pintar el valor $00 que el contenido de la
                        ; posición $00

        rts             ; vuelve a BASIC
