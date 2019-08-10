; Librería de rutinas para manejar caracteres

.DATA

; Rutina para copiar un bloque de datos
; Vale para N caracteres o cualquier otra cosa

cbComienzoLo:    .byte $00
cbComienzoHi:    .byte $00

cbFinLo:         .byte $00
cbFinHi:         .byte $00

cbDestinoLo:     .byte $00
cbDestinoHi:     .byte $00


copiaBloque:

        ldy #$00

        lda cbComienzoLo
        sta $fb
        lda cbComienzoHi
        sta $fc

        lda cbDestinoLo
        sta $fd
        lda cbDestinoHi
        sta $fe

cbBucle:

        lda ($fb),y
        sta ($fd),y

        lda $fb
        clc
        adc #$01
        sta $fb

        lda $fc
        adc #$00
        sta $fc

        lda $fd
        clc
        adc #$01
        sta $fd

        lda $fe
        adc #$00
        sta $fe

        lda $fb
        cmp cbFinLo
        bne cbBucle

        lda $fc
        cmp cbFinHi
        bne cbBucle

        rts

; Rutina para activar un juego de caracteres

acJuego: .byte $00

activaJuego:

        lda acJuego
        and #%00000111
        asl a
        sta acJuego

        lda VMCSB
        and #%11110001
        ora acJuego
        sta VMCSB

        rts

; Rutina para activar el multicolor

activaMulticolor:

        lda SCROLX
        ora #%00010000
        sta SCROLX
        rts

; Rutina para configurar los colores

colorFondo0:     .byte $00
colorFondo1:     .byte $00
colorFondo2:     .byte $00

configuraColores:

        lda colorFondo0
        sta BGCOL0

        lda colorFondo1
        sta BGCOL1

        lda colorFondo2
        sta BGCOL2

        rts

; Rutina para rellenar la pantalla con un carácter

rpCaracter:      .byte $00

rellenaPantalla:

        ldx #$00

        lda rpCaracter

rpBucle: sta VICSCN,x
        sta VICSCN+250,x
        sta VICSCN+500,x
        sta VICSCN+750,x

        inx

        cpx #250
        bne rpBucle

        rts

; Rutina para rellenar la pantalla con un color

rcColor:         .byte $00

rellenaColor:

        ldx #$00

        lda rcColor

rcBucle: sta COLORRAM,x
        sta COLORRAM+250,x
        sta COLORRAM+500,x
        sta COLORRAM+750,x

        inx

        cpx #250
        bne rcBucle

        rts
