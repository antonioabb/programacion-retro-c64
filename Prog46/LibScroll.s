; Librería de rutinas para manejar scroll

.DATA

; Rutina para activar 38 columnas

activa38Columnas:

        lda SCROLX
        and #%11110111
        sta SCROLX
        rts

; Rutina para activar 24 filas

activa24Filas:

        lda SCROLY
        and #%11110111
        sta SCROLY
        rts

; Rutina para poner el scroll X en 0...7 pixels

fsX:     .byte $00

fijaScrollX:

        lda fsX
        and #%00000111
        sta fsX

        lda SCROLX
        and #%11111000
        ora fsX
        sta SCROLX

        rts

; Rutina para poner el scroll Y en 0...7 pixels

fsY:     .byte $00

fijaScrollY:

        lda fsY
        and #%00000111
        sta fsY

        lda SCROLY
        and #%11111000
        ora fsY
        sta SCROLY

        rts

; Tabla que te da el comienzo de cada fila en función del índice x

tablaFilasLo:

        .byte $00,$28,$50,$78,$A0,$C8,$F0,$18,$40
        .byte $68,$90,$B8,$E0,$08,$30,$58,$80,$A8
        .byte $D0,$F8,$20,$48,$70,$98,$C0

tablaFilasHi:

        .byte $04,$04,$04,$04,$04,$04,$04,$05,$05
        .byte $05,$05,$05,$05,$06,$06,$06,$06,$06
        .byte $06,$06,$07,$07,$07,$07,$07

; Rutina para copiar la pantalla desplazada un carácter a la derecha

copiaDerecha:

        ldx #$00 ; Filas 0-24

        ldy #38  ; Columnas 0-39 (la 39 se tira)

cdBucle:

        lda tablaFilasLo,x
        sta $fb

        lda tablaFilasHi,x
        sta $fc

        lda ($fb),y
        iny
        sta ($fb),y
        dey

        dey

        cpy #$ff
        bne cdBucle

        inx

        cpx #25
        beq cdFin

        ldy #38
        jmp cdBucle

cdFin:

        rts

; Rutina para copiar la pantalla desplazada un carácter a la izquierda

copiaIzquierda:

        ldx #$00 ; Filas 0-24

        ldy #1   ; Columnas 0-39 (la 0 se tira)

ciBucle:

        lda tablaFilasLo,x
        sta $fb

        lda tablaFilasHi,x
        sta $fc

        lda ($fb),y
        dey
        sta ($fb),y
        iny

        iny

        cpy #40
        bne ciBucle

        inx

        cpx #25
        beq ciFin

        ldy #1
        jmp ciBucle

ciFin:

        rts
