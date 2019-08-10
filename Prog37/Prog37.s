; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/01/18/colisiones-de-sprites/
; Prog37
;
; Programa para ejemplificar las colisiones entre sprites
;
; En esta ocasión en vez de macros usamos rutinas, y pasamos los parámetros
; de entrada / salida mediante posiciones de memoria
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Mem.s"
.include "ConstJoy.s"
.include "ConstMov.s"
.include "ConstSprites.s"

.include "Sprites.s"

.include "LibJoy.s"
.include "LibMov.s"
.include "LibSprites.s"
.include "LibTemp.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

; Programa principal

Prog37:
        jsr limpiaPantalla
        jsr inicializaVariables
        jsr inicializaSprites

bucle:

        jsr mueveSprite0
        jsr analizaColision

        lda colision
        beq cont1

        rts

cont1:   jsr retarda

        jsr mueveSprite1
        jsr analizaColision

        lda colision
        beq cont2

        rts

cont2:   jsr retarda

        jmp bucle

; Variables

sprite0X:        .byte $00
sprite0Y:        .byte $00

sprite1X:        .byte $00
sprite1Y:        .byte $00

colision:        .byte $00

; Rutinas

analizaColision:

        lda #$00
        sta dcNumero1

        lda #$01
        sta dcNumero2

        jsr detectaColision

        lda dcColision
        sta colision

        rts

retarda:

        lda #$00
        sta retardoLo

        lda #$01
        sta retardoHi

        jsr meteRetardo

        rts

mueveSprite1:

        ; Lee el joystick A
        jsr leeJoystickA

        ; Hay movimiento?
        lda joyA
        cmp #Nada
        beq ms1Fin

        ; Calcula la nueva posición
        lda sprite1X
        sta npX

        lda sprite1Y
        sta npY

        lda joyA
        sta npJoy

        jsr nuevaPosicion

        ; Verifica los límites X
        lda npNX
        sta vlxNX

        jsr verificaLimitesX

        ; Verifica los límites Y
        lda npNY
        sta vlyNY

        jsr verificaLimitesY

        ; Toma la nueva posición
        lda vlxNX
        sta sprite1X

        lda vlyNY
        sta sprite1Y

        ; Posiciona el sprite1
        lda #$01
        sta psNumero

        lda sprite1X
        sta psCoordX

        lda sprite1Y
        sta psCoordY

        jsr posicionaSprite

ms1Fin:

        rts

mueveSprite0:

        ; Lee el joystick B
        jsr leeJoystickB

        ; Hay movimiento?
        lda joyB
        cmp #Nada
        beq ms0Fin

        ; Calcula la nueva posición
        lda sprite0X
        sta npX

        lda sprite0Y
        sta npY

        lda joyB
        sta npJoy

        jsr nuevaPosicion

        ; Verifica los límites X
        lda npNX
        sta vlxNX

        jsr verificaLimitesX

        ; Verifica los límites Y
        lda npNY
        sta vlyNY

        jsr verificaLimitesY

        ; Toma la nueva posición
        lda vlxNX
        sta sprite0X

        lda vlyNY
        sta sprite0Y

        ; Posiciona el sprite0
        lda #$00
        sta psNumero

        lda sprite0X
        sta psCoordX

        lda sprite0Y
        sta psCoordY

        jsr posicionaSprite

ms0Fin:

        rts

inicializaSprites:

        ; Copia los datos del sprite0
        lda #<frame0
        sta cdOrigenLo
        lda #>frame0
        sta cdOrigenHi

        lda #<Bloque0
        sta cdDestinoLo
        lda #>Bloque0
        sta cdDestinoHi

        jsr copiaDatos

        ; Copia los datos del sprite1
        lda #<frame0
        sta cdOrigenLo
        lda #>frame0
        sta cdOrigenHi

        lda #<Bloque1
        sta cdDestinoLo
        lda #>Bloque1
        sta cdDestinoHi

        jsr copiaDatos

        ; Configura el multicolor
        lda #Negro
        sta cmMulticolor1

        lda #Amarillo
        sta cmMulticolor2

        jsr configuraMulticolor

        ; Hace la configuración básica del sprite0
        lda #$00
        sta cbNumero

        lda #254
        sta cbBloque

        lda #Verde
        sta cbColor

        jsr configuraBasica

        ; Hace la configuración avanzada del sprite0
        lda #$00
        sta caNumero

        lda #$01
        sta caMulticolor

        lda #$00
        sta caExpansionH
        sta caExpansionV

        lda #$01
        sta caPrioFondo

        jsr configuraAvanzada

        ; Posiciona el sprite0
        lda #$00
        sta psNumero

        lda sprite0X
        sta psCoordX

        lda sprite0Y
        sta psCoordY

        jsr posicionaSprite

        ; Hace la configuración básica del sprite1
        lda #$01
        sta cbNumero

        lda #255
        sta cbBloque

        lda #Rojo
        sta cbColor

        jsr configuraBasica

        ; Hace la configuración avanzada del sprite1
        lda #$01
        sta caNumero

        lda #$01
        sta caMulticolor

        lda #$00
        sta caExpansionH
        sta caExpansionV

        lda #$01
        sta caPrioFondo

        jsr configuraAvanzada

        ; Posiciona el sprite1
        lda #$01
        sta psNumero

        lda sprite1X
        sta psCoordX

        lda sprite1Y
        sta psCoordY

        jsr posicionaSprite

        rts

inicializaVariables:

        lda #100
        sta sprite0X

        lda #150
        sta sprite0Y

        lda #200
        sta sprite1X

        lda #150
        sta sprite1Y

        rts

limpiaPantalla:

        lda #147
        jsr CHROUT

        rts
