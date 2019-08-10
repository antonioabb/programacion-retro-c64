; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/12/09/subrutinas/
; Prog20
;
; Programa para ejemplificar el uso de subrutinas
;
; Ya se han presentado muchos ejemplos con subrutinas. Por ello, este ejemplo
; mostrará el uso de una "jump table", que es un mecanismo similar al que usa
; el Kernal para permitir la reubicación de rutinas del SO en memoria sin grandes
; problemas.

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog20:
        jsr rutina1     ; Llama a la rutina 1
        jsr rutina2     ; Llama a la rutina 2
        rts             ; Vuelve a BASIC

; Esta es la "jump table"

; En el fondo es una tabla de instrucciones jmp con saltos a las direcciones
; reales en las que están ubicadas las rutinas. De este modo, sería posible
; mover las rutinas a otas direcciones sin que el programa principal se
; viera afectado. Esto es así porque el programa principal usa la "jump table"

; El Kernal del C64 utiliza un mecanismo idéntico a este para sus rutinas

rutina1: jmp rutina1Real ; La rutina 1 en realidad está en otro sitio
rutina2: jmp rutina2Real ; La rutina 2 también

rutina1Real:

        lda #$01
        sta $0400
        rts

rutina2Real:

        lda #$02
        sta $0401
        rts
