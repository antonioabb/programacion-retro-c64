; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/01/01/prioridades-de-sprites/
; Prog35
;
; Programa para ejemplificar las prioridades de sprites
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
        ;arg1 = dirección de origen
        ;arg2 = dirección de destino

        .local bucle

        ldx #$00

bucle:  lda arg1,x
        sta arg2,x

        inx

        cpx #$40

        bne bucle
.endmacro

; Macro para configurar los colores del multicolor (colores compartidos)

.macro CONF_MULTICOLOR_VV arg1, arg2
        ;arg1 = multicolor 1
        ;arg2 = multicolor 2

        lda #arg1
        sta multicolor1

        lda #arg2
        sta multicolor2
.endmacro

; Macro para hacer la configuración básica de un sprite: puntero, activar y
; color del sprite

.macro CONF_BASICA_VDV arg1, arg2, arg3
        ;arg1 = número del sprite
        ;arg2 = dirección de los datos
        ;arg3 = color del sprite

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
; expansión horizontal y vertical, y prioridad respecto al fondo

.macro CONF_AVANZADA_VVVVV arg1, arg2, arg3, arg4, arg5
        ;arg1 = número del sprite
        ;arg2 = multicolor
        ;arg3 = expansión horizontal
        ;arg4 = expansión vertical
        ;arg5 = prioridad respecto al fondo

        .local exp_hor
        .local exp_ver
        .local prio
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
        beq prio

        lda tabla,x
        ora expver
        sta expver

prio:
        lda #arg5
        bne fin

        lda tabla,x
        ora prioback
        sta prioback

fin:    nop
.endmacro

; Macro para posicionar un sprite

.macro POSICION_VVV arg1, arg2, arg3
        ;arg1 = número del sprite
        ;arg2 = posición X
        ;arg3 = posición Y

        lda #arg1
        asl a
        tax

        lda #arg2
        sta posicionx0,x

        lda #arg3
        sta posiciony0,x
.endmacro

; Programa

Prog35:
        COPIA_DATOS_DD frame0,bloque0   ; Copia los datos del frame0
        COPIA_DATOS_DD frame1,bloque1   ; Copia los datos del frame1

        CONF_MULTICOLOR_VV rojo,amarillo; Configura los colores compartidos

        CONF_BASICA_VDV 0,254,negro     ; Configura el sprite0 apunt. a frame0
        CONF_AVANZADA_VVVVV 0,1,0,0,0   ; Configura el sprite0 sin prioridad
        POSICION_VVV 0,120,65           ; Posiciona el sprite0 en 120,65

        CONF_BASICA_VDV 1,254,negro     ; Configura el sprite1 apunt. a frame0
        CONF_AVANZADA_VVVVV 1,1,0,0,1   ; Configura el sprite1 con prioridad
        POSICION_VVV 1,160,65           ; Posiciona el sprite1 en 160,65

        rts

; Tabla para convertir entre número de sprite y el bit correspondiente

tabla:   .byte 1,2,4,8,16,32,64,128
