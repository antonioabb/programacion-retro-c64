; Librería de rutinas para manejar sonido con el SID

.DATA

; Imagen del SID

imagenSID:       .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

; Rutina para inicializar la imagen del SID

inicializaImagenSID:

                ldx #$00

                lda #$00
iiBucle:         sta imagenSID,x

                inx
                cpx #$19

                bne iiBucle

                rts

; Rutina para copiar la imagen del SID al SID

transfiereImagenSID:

                ldx #$00

tiBucle:         lda imagenSID,x
                sta FRELO1,x

                inx
                cpx #$19

                bne tiBucle

                rts

; Rutina para fijar el volumen

volumen: .byte $00

fijaVolumen:

        lda volumen
        and #%00001111
        sta volumen

        lda imagenSID+$18
        ora volumen
        sta imagenSID+$18

        rts

; Rutina para fijar la frecuencia de la voz1

freclo:  .byte $00
frechi:  .byte $00

fijaFrecuencia:

        lda freclo
        sta imagenSID+$00

        lda frechi
        sta imagenSID+$01

        rts

; Rutina para fijar la forma de onda de la voz1

formaOnda:       .byte $00

fijaFormaOnda:

        lda formaOnda
        and #%00001111
        asl a
        asl a
        asl a
        asl a
        sta formaOnda

        lda imagenSID+4
        ora formaOnda
        sta imagenSID+4

        rts

; Rutina para fijar el ADSR de la voz1

attack:  .byte $00
decay:   .byte $00
sustain: .byte $00
release: .byte $00

fijaADSR:

        lda attack
        and #$0f
        asl a
        asl a
        asl a
        asl a
        sta attack

        lda decay
        and #$0f
        sta decay

        ora attack
        sta imagenSID+$05

        lda sustain
        and #$0f
        asl a
        asl a
        asl a
        asl a
        sta sustain

        lda release
        and #$0f
        sta release

        ora sustain
        sta imagenSID+$06

        rts

; Rutina para activar la voz1

activaVoz:

        lda imagenSID+$04
        ora #%00000001
        sta imagenSID+$04

        rts

; Rutina para desactivar la voz1

desactivaVoz:

        lda imagenSID+$04
        and #%11111110
        sta imagenSID+$04

        rts
