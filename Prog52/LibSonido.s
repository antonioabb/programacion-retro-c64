; Librería de rutinas para manejar sonido con el SID

.DATA

; Imagen del SID

imagenSID:       .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

; Índices para las 3 voces

; Para poder usar 1, 2 y 3 como índices (en vez de 0, 1 y 2) añadimos
; un $00 inicial; así tanto 0 como 1 designan la voz 1 (offset $00)

offsetVoces:     .byte $00,$00,$07,$0e

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

; Rutina para fijar la frecuencia de la voz X

frecLo:  .byte $00
frecHi:  .byte $00
ffVoz:   .byte $00

fijaFrecuencia:

        ldx ffVoz
        lda offsetVoces,x
        tax

        lda frecLo
        sta imagenSID+$00,x

        lda frecHi
        sta imagenSID+$01,x

        rts

; Rutina para fijar la forma de onda de la voz X

formaOnda:       .byte $00
ffoVoz:          .byte $00

fijaFormaOnda:

        ldx ffoVoz
        lda offsetVoces,x
        tax

        lda formaOnda
        and #%00001111
        asl a
        asl a
        asl a
        asl a
        sta formaOnda

        lda imagenSID+$04,x
        ora formaOnda
        sta imagenSID+$04,x

        rts

; Rutina para fijar el ADSR de la voz X

attack:  .byte $00
decay:   .byte $00
sustain: .byte $00
release: .byte $00
faVoz:   .byte $00

fijaADSR:

        ldx faVoz
        lda offsetVoces,x
        tax

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
        sta imagenSID+$05,x

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
        sta imagenSID+$06,x

        rts

; Rutina para fijar el ancho de pulso de la voz X

anchoPulsoLo:    .byte $00
anchoPulsoHi:    .byte $00
fapVoz:          .byte $00

fijaAnchoPulso:

        ldx fapVoz
        lda offsetVoces,x
        tax

        lda anchoPulsoLo
        sta imagenSID+$02,x

        lda anchoPulsoHi
        sta imagenSID+$03,x

        rts

; Rutina para configurar un filtro sobre la voz X

tipoFiltro:      .byte $00
frecCorteLo:     .byte $00
frecCorteHi:     .byte $00
cfVoz:           .byte $00

configuraFiltro:

        ldx cfVoz
        lda offsetVoces,x
        tax

        lda tipoFiltro
        and #%01110000
        sta tipoFiltro

        lda imagenSID+$18,x
        ora tipoFiltro
        sta imagenSID+$18,x

        lda frecCorteLo
        and #%00000111
        sta frecCorteLo

        lda imagenSID+$15,x
        ora frecCorteLo
        sta imagenSID+$15,x

        lda imagenSID+$16,x
        ora frecCorteHi
        sta imagenSID+$16,x

        lda imagenSID+$17,x
        ora #%00000001
        sta imagenSID+$17,x

        rts

; Rutina para activar la voz X

avVoz:   .byte $00

activaVoz:

        ldx avVoz
        lda offsetVoces,x
        tax

        lda imagenSID+$04,x
        ora #%00000001
        sta imagenSID+$04,x

        rts

; Rutina para desactivar la voz X

dvVoz:   .byte $00

desactivaVoz:

        ldx dvVoz
        lda offsetVoces,x
        tax

        lda imagenSID+$04,x
        and #%11111110
        sta imagenSID+$04,x

        rts

; Rutina para obtener la frecuencia a partir de octava y nota

; Tabla de conversión partiendo de octava 7 y dividiendo

tablaConversionLo:

        .byte $1E,$18,$8B,$7E,$FA,$06,$AC,$F3,$E6,$8F,$F8,$2E

tablaConversionHi:

        .byte $86,$8E,$96,$9F,$A8,$B3,$BD,$C8,$D4,$E1,$EE,$FD

octava:  .byte $00
nota:    .byte $00
frec2Lo: .byte $00
frec2Hi: .byte $00

obtenFrec:

        ; Obtiene la parte Lo de la frecuencia en función de la nota
        ldx nota
        lda tablaConversionLo,x
        sta divNumLo

        ; Obtiene la parte Hi de la frecuencia en función de la nota
        lda tablaConversionHi,x
        sta divNumHi

        ; Calcula el número de divisiones: 7 - octava
        lda #$07
        sec
        sbc octava

        ; Divide la frecuencia por 2 N veces en función de la octava
        sta divVeces
        jsr divide2NVeces

        ; El resultado de la división, a la salida
        lda divResLo
        sta frec2Lo

        lda divResHi
        sta frec2Hi

        rts
