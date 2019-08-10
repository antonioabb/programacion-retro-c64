; Librería de rutinas para el bitmap

.DATA

; Rutina para activar el bitmap

abBase:  .byte $00

activaBitmap:

        lda abBase
        and #%00000001
        asl a
        asl a
        asl a
        sta abBase

        lda VMCSB
        and #%11110111
        ora abBase
        sta VMCSB

        lda SCROLY
        ora #%00100000
        sta SCROLY
        rts

; Rutina para rellenar un bloque de datos con un .byte

rbComienzoLo:    .byte $00
rbComienzoHi:    .byte $00

rbFinLo:         .byte $00
rbFinHi:         .byte $00

rbByte:          .byte $00

rellenaBloque:

        ldy #$00

        lda rbComienzoLo
        sta $fb
        lda rbComienzoHi
        sta $fc

rbBucle:

        lda rbByte
        sta ($fb),y

        lda $fb
        clc
        adc #$01
        sta $fb

        lda $fc
        adc #$00
        sta $fc

        lda $fb
        cmp rbFinLo
        bne rbBucle

        lda $fc
        cmp rbFinHi
        bne rbBucle

        rts
