; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/12/10/interrupciones/
; Prog26
;
; Programa para ejemplificar las interrupciones
;
; En este caso la rutina de interrupción del usuario es completa, sustituye
; a la del sistema
;
; Se observará cómo un carácter va cambiando en la esquina superior izquierda
; de la pantalla, EN VEZ DE parpadear el cursor
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog26:
        sei             ; Deshabilita las interrupciones temporalmente

        lda #<rutinaInt ; Configura el vector de interrupción; parte low
        sta $0314

        lda #>rutinaInt ; Configura el vector de interrupción; parte high
        sta $0315

        cli             ; Vuelve a habilitar las interrupciones

        rts             ; Vuelve a BASIC

; A partir de aquí, cada vez que haya una interrupción, se ejecutará
; nuestra rutina de interrupción (ver abajo); la del sistema ya no se ejecutará

cont:    .byte $00

rutinaInt:

        inc cont        ; Incrementa el contador

        lda cont        ; Carga el contador

        sta $0400       ; Lo pinta en la esquina sup - izqda de la pantalla

        pla             ; Recupera el registro Y
        tay

        pla             ; Recupera el registro X
        tax

        pla             ; Recupera el acumulador

        rti             ; Termina la interrupción


        ; Este trocito de código se ejecuta EN VEZ de ejecutar la rutina
        ; habitual del sistema, que está en $ea31...
