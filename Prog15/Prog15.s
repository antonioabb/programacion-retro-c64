; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/22/instrucciones-para-operaciones-aritmeticas-multiplicacion-y-division/
; Prog15
;
; Programa para ejemplificar multiplicaciones y divisiones sencillas
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Utils.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Constantes

valor = %00001000       ; 8 en decimal

Prog15:
        lda #valor      ; Carga el valor en el acumulador
        jsr imprimeAcum ; Imprime el acumulador en binario

        asl a           ; Corre los bits 1 posición a la izq
                        ; Esto equivale a multiplicar por dos
                        ; Observar el modo de direcc. "acumulador"

        jsr imprimeAcum ; Imprime el acumulado en binario

        asl             ; El ensamblador también lo entiendo sin "a"

        jsr imprimeAcum

        lsr a           ; Corre los bits 1 posición a la dcha
                        ; Esto equivale a dividir por dos
                        ; Observar el modo de direcc. "acumulador"

        jsr imprimeAcum

        lsr             ; El ensamblador también lo entiende sin "a"

        jsr imprimeAcum

        rts
