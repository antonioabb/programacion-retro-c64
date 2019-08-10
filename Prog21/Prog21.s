; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/12/09/macros/
; Prog21
;
; Programa para ejemplificar el uso de macros
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Esta macro pinta un carácter X en una posición de pantalla Y
;
; Es habitual que el nombre se ponga en mayúsculas (convenio),
; y añadir al final una letra por cada parámetro, que será una D
; en el caso de una dirección, y una V en el caso de un valor
.macro  PINTA_PANTALLA_VD arg1, arg2
    lda #arg1   ; /1 pasará el carácter a pintar
    sta arg2   ; /2 pasará la posición de pantalla
.endmacro

; Si se analiza el código máquina generado tras ensamblar, por ejemplo con el
; depurador/debugger, se verá que cada "llamada" a PINTA_PANTALLA_VD es
; sustituda por el código lda #arg1 sta arg2, y tanto en arg1 como en arg2 aparecen
; los parámetros pasados.

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog21:
    PINTA_PANTALLA_VD 1, $0400  ; Pinta el valor 1 en $0400
    PINTA_PANTALLA_VD 2, $0401  ; Pinta el valor 2 en $0401
    rts                         ; Vuelve a BASIC
