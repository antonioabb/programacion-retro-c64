; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/12/20/ram-de-color/
; Prog29
;
; Programa para ejemplificar el uso de la RAM de color
;
; Para cada color desde el $00 hasta el $0f, se lee un texto en memoria, se
; pinta ese texto en un línea de la RAM de pantalla, y luego se pinta con un
; color en la RAM de color.
;
; El color que estamos procesando lo va a controlar el índice X. Para cada
; X, para leer el texto, pintarlo en pantalla y pintar el color vamos a usar
; una tabla. Esa tabla (que en realidad tiene 2 partes: parte low y parte high,
; o parte LSB y MSB, como se quiere decir) nos dice dónde empieza la línea
; de texto a leer, la línea a pintar en pantalla, y la línea donde pintar el
; color. Por "donde empieza" me refiero al offset respecto al origen.
;
; Como las líneas de texto se ha diseñado de 40 caracteres, igual que el ancho
; de pantalla, con una tabla nos vale para las 3 funciones: leer, escribir y
; pintar el color. Y de paso los caracteres en blanco hasta rellenar 40 tienen
; el efecto secundario beneficioso de borrar el texto que pudiera haber antes
; en la pantalla.
;
; Esa tabla, que en el fondo no es más que la función 40*X, se podría imple-
; mentar como una función matemática, pero en ensamblador casi resulta más
; cómodo manejar una tabla de datos que dado X te dé f(X). Además CMB prg
; Studio tiene en Tools > Data Generator una utilidad muy cómoda para generar
; estas tablas.

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog29:
        ldx #$00

bucle:  jsr imprimeLinea
        jsr pintaColor

        inx

        cpx #$10                ; Son 16 colores, del $00 al $0f
        bne bucle

        lda #$10  ; Colocar cursor en Fila 16
        sta $d6   ; Fila del cursor

        rts

imprimeLinea:
        ; Prepara el puntero $fb-$fc al comienzo de la tabla de textos
        lda #<textos
        sta $fb

        lda #>textos
        sta $fc

        ; En función de X, suma un offset para apuntar a la línea correcta
        lda offsetTextosLo,x
        clc
        adc $fb
        sta $fb

        lda offsetTextosHi,x
        adc $fc
        sta $fc

        ; Prepara el puntero $fd-$fe al comienzo de la pantalla
        lda #<$0400
        sta $fd

        lda #>$0400
        sta $fe

        ; En función de X, suma un offset para apuntar a la línea correcta
        lda offsetTextosLo,x
        clc
        adc $fd
        sta $fd

        lda offsetTextosHi,x
        adc $fe
        sta $fe

        ; Lee en ($fb-$fc)+offset
        ldy #$00
bucle2:  lda ($fb),y

        ; Pinta en ($fd-$fe)+offset
        sta ($fd),y

        ; Incrementa Y
        iny

        ; Hemos llegado a 40?
        cpy #40
        bne bucle2

        rts

pintaColor:
        ; Prepara el puntero $fd-$fe al comienzo de la RAM de color
        lda #<$d800
        sta $fd

        lda #>$d800
        sta $fe

        ; En función de X, suma un offset para apuntar a la línea correcta
        lda offsetTextosLo,x
        clc
        adc $fd
        sta $fd

        lda offsetTextosHi,x
        adc $fe
        sta $fe

        ; El color llega en X
        txa

        ; Pinta en ($fd-$fe)+offset
bucle3:  sta ($fd),y
        ; Incrementa Y
        iny

        ; Hemos llegado a 40?
        cpy #40
        bne bucle3

        rts

textos:
        .byte "NEGRO                                   "
        .byte "BLANCO                                  "
        .byte "ROJO                                    "
        .byte "CYAN                                    "
        .byte "MORADO                                  "
        .byte "VERDE                                   "
        .byte "AZUL                                    "
        .byte "AMARILLO                                "
        .byte "NARANJA                                 "
        .byte "MARRON                                  "
        .byte "ROJO CLARO                              "
        .byte "GRIS OSCURO                             "
        .byte "GRIS MEDIO                              "
        .byte "VERDE CLARO                             "
        .byte "AZUL CLARO                              "
        .byte "GRIS CLARO                              "

offsetTextosLo:
        .byte $00,$28,$50,$78,$A0,$C8,$F0,$18,$40
        .byte $68,$90,$B8,$E0,$08,$30,$58

offsetTextosHi:
        .byte $00,$00,$00,$00,$00,$00,$00,$01,$01
        .byte $01,$01,$01,$01,$02,$02,$02
