; Librería de rutinas para manejar sprites

.DATA

; Tabla para convertir entre número de sprite y el bit correspondiente

tablaSpr:        .byte 1,2,4,8,16,32,64,128

; Rutina para copiar los 64 .bytes de un sprite

cdOrigenLo:      .byte $00
cdOrigenHi:      .byte $00

cdDestinoLo:     .byte $00
cdDestinoHi:     .byte $00

copiaDatos:

        ldy #$00

        lda cdOrigenLo
        sta $fb
        lda cdOrigenHi
        sta $fc

        lda cdDestinoLo
        sta $fd
        lda cdDestinoHi
        sta $fe

cdBucle: lda ($fb),y
        sta ($fd),y

        iny

        cpy #$40

        bne cdBucle

        rts

; Rutina para configurar el multicolor

cmMulticolor1:   .byte $00
cmMulticolor2:   .byte $00

configuraMulticolor:

        lda cmMulticolor1
        sta SPMC0

        lda cmMulticolor2
        sta SPMC1

        rts

; Rutina para hacer la configuración básica de un sprite

cbNumero:        .byte $00
cbBloque:        .byte $00
cbColor:         .byte $00

configuraBasica:

        ldx cbNumero

        lda cbBloque
        sta SPRITE0,x

        lda tablaSpr,x
        ora SPENA
        sta SPENA

        lda cbColor
        sta SP0COL,x

        rts

; Rutina para posicionar un sprite

psNumero:        .byte $00
psCoordX:        .byte $00
psCoordY:        .byte $00

posicionaSprite:

        lda psNumero
        asl a
        tax

        lda psCoordX
        sta SP0X,x

        lda #$00
        sta MSIGX

        lda psCoordY
        sta SP0Y,x

        rts

; Rutina para hacer la configuración avanzada de un sprite

caNumero:        .byte $00
caMulticolor:    .byte $00
caExpansionH:    .byte $00
caExpansionV:    .byte $00
caPrioFondo:     .byte $00

configuraAvanzada:

        ldx caNumero

        lda caMulticolor
        beq caExphor

        lda tablaSpr,x
        ora SPMC
        sta SPMC

caExphor:

        lda caExpansionH
        beq caExpver

        lda tablaSpr,x
        ora XXPAND
        sta XXPAND

caExpver:

        lda caExpansionV
        beq caPrio

        lda tablaSpr,x
        ora YXPAND
        sta YXPAND

caPrio:

        lda caPrioFondo
        bne caFin

        lda tablaSpr,x
        ora SPBGPR
        sta SPBGPR

caFin:

        rts

; Rutina para detectar la colisión de dos sprites

; Esta rutina es sencilla, porque no entra a valorar la posición de los sprites
; Simplemente analiza si los bits dcNumero1 y dcNumero2 están activos

; Se podría hacer una versión más elaborada que tuviera en cuenta las posiciones

dcNumero1:       .byte $00
dcNumero2:       .byte $00
dcColision:      .byte $00

dcTemp:          .byte $00

detectaColision:

        lda SPSPCL
        sta dcTemp

        ldx dcNumero1
        lda tablaSpr,x

        bit dcTemp
        bne dcSgte

        lda #$00
        sta dcColision
        rts

dcSgte:

        ldx dcNumero2
        lda tablaSpr,x

        bit dcTemp
        bne dcFin

        lda #$00
        sta dcColision
        rts

dcFin:

        lda #$01
        sta dcColision

        rts
