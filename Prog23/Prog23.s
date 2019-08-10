; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/12/09/instrucciones-de-manejo-de-la-pila/
; Prog23
;
; Programa para ejemplificar el uso de la pila
;
; Concretamente, vamos a guardar los registros en la pila, usar una rutina,
; y luego recuperarlos
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Utils.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog23:
        lda #$01
        ldx #$02
        ldy #$03

        jsr rutinaModif ; Primera llamada para imprimir valores

        jsr rutinaModif ; Segunda llamada para verificar que algunos cambian

        lda #$01
        ldx #$02
        ldy #$03

        jsr rutinaNoModif ; Primera llamada para imprimir valores

        jsr rutinaNoModif ; Segunda llamada para verificar que ya no cambian

        rts

; Esta rutina imprime el contenido de los registros A, X, e Y
; Pero en el proceso de hacerlo los modifica
; Esto es fácil de comprobar si se utiliza dos veces seguidas; se verá
; que la segunda vez no se imprimen los mismos valores que en la primera

rutinaModif:

        jsr imprimeAcum ; Imprime el acumulador

        txa
        jsr imprimeAcum ; Imprime el registro X

        tya
        jsr imprimeAcum ; Imprime el registro Y

        lda #13         ; Imprime un retorno de carro
        jsr chrout

        rts

; Esta rutina imprime el contenido de los registros A, X e Y
; Pero antes de hacerlo los pone a salvo y al final los recupera
; Gracias a ello no modifica sus valores
; De hecho, se apoya en la rutina anterior que sí los modifica

rutinaNoModif:

        pha     ; Pone a salvo el acumulador

        txa     ; Pone a salvo el registro X
        pha

        tya     ; Pone a salvo el registro Y
        pha

        jsr rutinaModif ; Imprime los registros... y modifica algunos!!

        pla     ; Pero luego los regupera de la pila... en orden inverso!!
        tay

        pla
        tax

        pla

        rts
