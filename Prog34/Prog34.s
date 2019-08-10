; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/12/31/animacion-de-sprites/
; Prog34
;
; Programa para ejemplificar la animación de sprites
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
.endmacro

; Macro para posicionar un sprite

.macro POSICION_VVV arg1, arg2, arg3
        ;/1 = número del sprite
        ;/2 = posición X
        ;/3 = posición Y

        lda #arg1
        asl a
        tax

        lda #arg2
        sta posicionx0,x

        lda #arg3
        sta posiciony0,x
.endmacro

; Macro para esperar

.macro ESPERA1_V arg1
        ;/1 = número de interaciones a esperar

        ldx #arg1
@bucle  beq @fin
        dex
        jmp @bucle

@fin    nop
.endmacro

; Macro para esperar

.macro ESPERA2_VV arg1, arg2
        ;/1 = línea RASTER a esperar
        ;/2 = número de veces a pasar

        .local bucle

        ldx #arg2

bucle:  lda raster
        cmp #arg1
        bne bucle

        dex
        bne bucle
.endmacro

; Programa

Prog34:
        COPIA_DATOS_DD frame0,bloque0   ; Copia los datos del frame0
        COPIA_DATOS_DD frame1,bloque1   ; Copia los datos del frame1

        CONF_MULTICOLOR_VV rojo,amarillo; Configura los colores compartidos

        CONF_AVANZADA_VVVV 0,1,0,0      ; Configura el sprite0 en multicolor
        POSICION_VVV 0,120,150          ; Posiciona el sprite0 en 120,150

anima:

        CONF_BASICA_VDV 0,254,negro     ; Configura el sprite0 apunt. a frame0

        ;ESPERA1_V 255                  ; Espera normal; no funciona
        ESPERA2_VV 255,30               ; Espera a raster=255; cuenta 30

        CONF_BASICA_VDV 0,255,negro     ; Configura el sprite0 apunt. a frame1

        ;ESPERA1_V 255                  ; Espera normal; no funciona
        ESPERA2_VV 255,30               ; Espera a raster=255; punt. a frame1

        jmp anima

; Tabla para convertir entre número de sprite y el bit correspondiente

tabla:   .byte 1,2,4,8,16,32,64,128
