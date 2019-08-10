; Librería de rutinas para cadenas de texto

.DATA

; Rutina para pintar un número BCD

numeroBCD:       .byte $00
posicionLo:      .byte $00
posicionHi:      .byte $00

tablaBCD:        .byte "0123456789"

pintaBCD:

        lda posicionLo
        sta $fb

        lda posicionHi
        sta $fc

        ldy #$00

        lda numeroBCD

        lsr a
        lsr a
        lsr a
        lsr a

        tax

        lda tablaBCD,x

        sta ($fb),y

        iny

        lda numeroBCD

        and #%00001111

        tax

        lda tablaBCD,x

        sta ($fb),y

        rts
