; Librería de rutinas para manejar el movimiento

.DATA

; Rutina para calcular la nueva posición

npX:     .byte $00
npY:     .byte $00
npJoy:   .byte $00
npNX:    .byte $00
npNY:    .byte $00

nuevaPosicion:

        lda npX
        sta npNX

        lda npY
        sta npNY

npDcha:

        lda #Derecha
        bit npJoy       ; Nos quedamos con el bit de derecha
        bne npIzqd      ; Si esta a 1 no hay derecha; seguimos

        inc npNX

npIzqd:

        lda #Izquierda
        bit npJoy       ; Nos quedamos con el bit de izquierda
        bne npAbjo      ; Si esta a 1 no hay izquierda; seguimos

        dec npNX

npAbjo:

        lda #Abajo
        bit npJoy       ; Nos quedamos con el bit de abajo
        bne npArri      ; Si esta a 1 no hay abajo; seguimos

        inc npNY

npArri:

        lda #Arriba
        bit npJoy       ; Nos quedamos con el bit de arriba
        bne npFin       ; Si esta a 1 no hay arriba; seguimos

        dec npNY

npFin:

        rts

; Rutina para verificar los límites X de la pantalla

vlxNX:   .byte $00

verificaLimitesX:

vlxDcha:

        lda vlxNX
        cmp #Xmax
        bcc vlxIzqd

        lda #Xmax
        sta vlxNX

        jmp vlxFin

vlxIzqd:

        lda vlxNX
        cmp #Xmin
        bcs vlxFin

        lda #Xmin
        sta vlxNX

vlxFin:

        rts

; Rutina para verificar los límites Y de la pantalla

vlyNY:   .byte $00

verificaLimitesY:

vlyAbjo:

        lda vlyNY
        cmp #Ymax
        bcc vlyArri

        lda #Ymax
        sta vlyNY

        jmp vlyFin

vlyArri:

        lda vlyNY
        cmp #Ymin
        bcs vlyFin

        lda #Ymin
        sta vlyNY

vlyFin:

        rts
