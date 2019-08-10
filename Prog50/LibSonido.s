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

frecLo:  .byte $00
frecHi:  .byte $00

fijaFrecuencia:

        lda frecLo
        sta imagenSID+$00

        lda frecHi
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

; Rutina para fijar el ancho de pulso de la voz1

anchoPulsoLo:    .byte $00
anchoPulsoHi:    .byte $00

fijaAnchoPulso:

        lda anchoPulsoLo
        sta imagenSID+$02

        lda anchoPulsoHi
        sta imagenSID+$03

        rts

; Rutina para configurar un filtro sobre la voz1

tipoFiltro:      .byte $00
frecCorteLo:     .byte $00
frecCorteHi:     .byte $00

configuraFiltro:

        lda tipoFiltro
        and #%01110000
        sta tipoFiltro

        lda imagenSID+$18
        ora tipoFiltro
        sta imagenSID+$18

        lda frecCorteLo
        and #%00000111
        sta frecCorteLo

        lda imagenSID+$15
        ora frecCorteLo
        sta imagenSID+$15

        lda imagenSID+$16
        ora frecCorteHi
        sta imagenSID+$16

        lda imagenSID+$17
        ora #%00000001
        sta imagenSID+$17

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
