; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/26/instrucciones-de-rotacion-de-bits/
; Prog19
;
; Programa para ejemplificar el uso de rol y ror
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Utils.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog19:
        lda #%10101010  ; Carga un byte en el acumulador
        sta numero      ; Lo pone en la posición de memoria de la rutina
        jsr imprime     ; Lo imprime en binario por pantalla

        ; Pregunta importante:
        ;
        ; ¿Habrá modificado la rutina el acumulador?
        ; No hay que dar por hecho que no lo habrá modificado
        ; Salvo que la rutina esté preparada para no modificarlo,
        ; por ejemplo, salvaguardando su valor al comienzo y recupe-
        ; rándolo al final

        rol a           ; Rota 9 veces
        rol a           ; 8 bits + el acarreo
        rol a           ; Debería volver al mismo valor
        rol a           ; Y en particular a %101010101 si la rutina
        rol a           ; de impresión no ha modificado el acumulador
        rol a
        rol a
        rol a
        rol a

        sta numero      ; Vuelve a imprmir el acumulador en binario
        jsr imprime     ; después de las 9 rotaciones

        ; Prueba:
        ;
        ; Después repetir la prueba comentando las instrucciones
        ; pha (meter en pila) y pla (sacar de pila) en la rutina
        ; 'imprime'
        ;
        ; Tras las 9 rotaciones el acumulador vuelve a tener el valor
        ; anterior a las 9 rotaciones, pero ese valor ya no es
        ; % 10101010, porque la rutina 'imprime' lo modifica

        rts
