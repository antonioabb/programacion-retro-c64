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

activaCars:

        lda acJuego
        and #%00000111
        asl a
        sta acJuego

        lda VMCSB
        and #%11110001
        ora acJuego
        sta VMCSB

        rts
