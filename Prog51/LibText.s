; Librería de rutinas para manejar números y cadenas de texto

.DATA

; Rutina para pintar un número en hexadecimal

numeroHex:       .byte $00

pintaHex:

        lda numeroHex

        lsr a
        lsr a
        lsr a
        lsr a

        jsr hexcii

        jsr chrout

        lda numeroHex

        and #%00001111

        jsr hexcii

        jsr chrout

        rts

; Rutina que convierte el nibble menos significativo del
; acumulador en su valor ascii

hexcii:

        cmp #$0a

        bcc hexnumero

hexletra:

        adc #$06

hexnumero:

        adc #$30

        rts

; Rutina que lee un .byte del teclado

byteLeido:       .byte $00

leeTeclado:

        jsr getin
        beq leeTeclado

        tax
        jsr chrout
        txa

        jsr aschex
        asl a
        asl a
        asl a
        asl a
        sta byteLeido

ltsegundo:

        jsr getin
        beq ltsegundo

        tax
        jsr chrout
        txa

        jsr aschex
        ora byteLeido

        rts

; Rutina que convierte el valor ascii de un dígito hexadecimal
; en un nibble con el valor equivalente

aschex:

        cmp #$40

        bcc ascnumero

ascletra:

        sbc #$07

ascnumero:

        sec
        sbc #$30

        rts

; Rutina para pintar un número en binario

numeroBin:       .byte $00

pintaBin:

        ldy #$08

pbbucle: rol numeroBin

        lda #$00
        adc #$30

        jsr chrout

        dey

        bne pbbucle

        rts

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

; Rutina para pintar una cadena

cadenaLo:        .byte $00
cadenaHi:        .byte $00

pintaCadena:

        lda cadenaLo
        sta $fb

        lda cadenaHi
        sta $fc

        ldy #$00

pcBucle:

        lda ($fb),y

        beq pcFin

        jsr chrout

        iny
        jmp pcBucle

pcFin:

        rts
