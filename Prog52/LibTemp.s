; Librería de rutinas para manejar el tiempo

.DATA

; Rutina para meter un retardo

retardoLo:       .byte $00
retardoHi:       .byte $00

meteRetardo:

        dec retardoLo
        bne meteRetardo

        dec retardoHi
        bne meteRetardo

        rts

; Rutina para esperar al raster

retRaster:       .byte $00

meteRetardoRaster:

        lda RASTER
        cmp retRaster
        bne meteRetardoRaster

        rts
