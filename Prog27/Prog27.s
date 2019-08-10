; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/12/10/otras-instrucciones/
; Prog27
;
; Programa para ejemplificar el uso de bit y nop
;
; El programa va a leer el joystick (posición CIAPRA) y, en función de su
; contenido, va a pintar una cosa u otra en pantalla.
;
; Cuando el joystick no se toca todos los bits de CIAPRA están a 1. Si el
; joystick apunta en una dirección, por ejemplo, a la izquierda, entonces
; el bit correspondiente se pone a 0.
;
; Es posible apuntar en dos direcciones a la vez, por ejemplo, izquierda y
; arriba, o abajo y derecha. En ese caso los dos bits asociados se ponen a 0.
;
; No es posible apuntar en 3 o 4 direcciones a la vez. Como mucho dos. Y además
; no pueden ser dos cualesquiera. Por ejemplo, arriba y abajo (o izquierda y
; derecha) a la vez no es posible.
;
; Además, está el disparo, que tiene su bit asociado. Cuando se pulsa el
; disparo el bit correspondiente se pone a 0.
;
; Los bits de CIAPRA asociados a cada función son:
; b7 - no aplica
; b6 - no aplica
; b5 - no aplica
; b4 - a 0 disparo
; b3 - a 0 derecha
; b2 - a 0 izquierda
; b1 - a 0 abajo
; b0 - a 0 arriba
;
; En el emulador VICE es posible emular el joystick mediante el teclado con
; Joystick Settings. Habrá que usar el Joystick 2 y configurar en el keyset B
; las teclas que se asocian a cada dirección (norte, sur, este, oeste y disp).
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Mem.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Constantes

mask = %00011111

nada = %00011111
disp = %00010000
dcha = %00001000
izqd = %00000100
abjo = %00000010
arri = %00000001

; Main

Prog27:

bucle:   lda CIAPRA      ; Lee el joystick
        and #mask       ; Se queda con los 5 bits de interés
        sta joy         ; Lo guarda en joy para hacer todas las comprobaciones
                        ; sobre el mismo valor leído (CIAPRB podría seguir
                        ; cambiando según se ejecuta el programa)
        cmp #nada
        beq bucle       ; Si no hay nada pulsado espera en bucle

        ; Si hemos llegado aquí es porque joy no tiene %11111
        ; Es decir, algo se ha pulsado; veamos qué

disp2:   lda #disp
        bit joy         ; Nos quedamos con el bit de disparo
        bne dcha2       ; Si esta a 1 no hay disparo; seguimos

        lda #$30        ; Pinta un 0 en la posición $0400
        sta $0400

dcha2:   lda #dcha
        bit joy         ; Nos quedamos con el bit de derecha
        bne izqd2       ; Si esta a 1 no hay derecha; seguimos

        lda #$30        ; Pinta un 0 en la posición $0401
        sta $0401

izqd2:   lda #izqd
        bit joy         ; Nos quedamos con el bit de izquierda
        bne abjo2       ; Si esta a 1 no hay izquierda; seguimos

        lda #$30        ; Pinta un 0 en la posición $0402
        sta $0402

abjo2:   lda #abjo
        bit joy         ; Nos quedamos con el bit de abajo
        bne arri2       ; Si esta a 1 no hay abajo; seguimos

        lda #$30        ; Pinta un 0 en la posición $0403
        sta $0403

arri2:   lda #arri
        bit joy         ; Nos quedamos con el bit de arriba
        bne fin         ; Si esta a 1 no hay arriba; seguimos

        lda #$30        ; Pinta un 0 en la posición $0404
        sta $0404

fin:    nop             ; Estas instrucciones no hacen nada
        nop
        nop

        lda #$20        ; Borra los ceros para la siguiente vuelta
        sta $0400
        sta $0401
        sta $0402
        sta $0403
        sta $0404

        jmp bucle

; Variables

joy:     .byte $00

; watch joy             ; Directiva del ensamblador
                        ; Al depurar permite ver el contenido de joy
