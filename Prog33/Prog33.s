; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/12/30/expansion-de-sprites/
; Prog33
;
; Programa para ejemplificar la expansión de sprites
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Const.s"
.include "Sprites.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Macro para copiar los datos de un sprite desde su ubicación provisional
; hasta su ubicación definitiva

.macro COPIA_DATOS_DD arg1, arg2
        ;/1 = dirección de origen
        ;/2 = dirección de destino

        ldx #$00

@bucle: lda arg1,x
        sta arg2,x

        inx

        cpx #$40

        bne @bucle
.endmacro

; Macro para configurar los colores del multicolor (colores compartidos)

.macro CONF_MULTICOLOR_VV arg1, arg2
        ;/1 = multicolor 1
        ;/2 = multicolor 2

        lda #arg1
        sta multicolor1

        lda #arg2
        sta multicolor2
.endmacro

; Macro para hacer la configuración básica de un sprite: puntero, activar y
; color del sprite

.macro CONF_BASICA_VDV arg1, arg2, arg3
        ;/1 = número del sprite
        ;/2 = dirección de los datos
        ;/3 = color del sprite

        ldx #arg1

        lda #arg2
        sta puntero0,x

        lda tabla,x
        ora activar
        sta activar

        lda #arg3
        sta color0,x
.endmacro

; Macro para hacer la configuración avanzada de un sprite: multicolor,
; expansión horizontal y vertical

.macro CONF_AVANZADA_VVVV arg1, arg2, arg3, arg4
; .scope
        ;/1 = número del sprite
        ;/2 = multicolor
        ;/3 = expansión horizontal
        ;/4 = expansión vertical

        .local exp_hor
        .local exp_ver
        .local fin

        ldx #arg1

        lda #arg2
        beq exp_hor

        lda tabla,x
        ora multicolor
        sta multicolor

exp_hor:
        lda #arg3
        beq exp_ver

        lda tabla,x
        ora exphor
        sta exphor

exp_ver:
        lda #arg4
        beq fin

        lda tabla,x
        ora expver
        sta expver

fin:
        nop
; .endscope
.endmacro

; Macro para posicionar un sprite

.macro POSICION_VVV arg1, arg2 ,arg3
        ;/1 = número del sprite
        ;/2 = posición X
        ;/3 = posición Y

        lda #arg1
        asl a
        tax

        lda #arg2        ; Fija la posición X del sprite 0
        sta posicionx0,x

        lda #arg3        ; Fija la posición Y del sprite 0
        sta posiciony0,x
.endmacro


; Programa

Prog33:
        COPIA_DATOS_DD sprites,bloque0

        CONF_MULTICOLOR_VV rojo,amarillo

        CONF_BASICA_VDV 0,254,negro
        CONF_AVANZADA_VVVV 0,1,0,0
        POSICION_VVV 0,120,150

        CONF_BASICA_VDV 1,254,negro
        CONF_AVANZADA_VVVV 1,1,0,1
        POSICION_VVV 1,150,150

        CONF_BASICA_VDV 2,254,negro
        CONF_AVANZADA_VVVV 2,1,1,0
        POSICION_VVV 2,180,150

        CONF_BASICA_VDV 3,254,negro
        CONF_AVANZADA_VVVV 3,1,1,1
        POSICION_VVV 3,230,150

        rts

; Tabla para convertir entre número de sprite y el bit correspondiente

tabla:   .byte 1,2,4,8,16,32,64,128
