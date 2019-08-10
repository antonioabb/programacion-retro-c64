; Librería de rutinas para entrada / salida

.DATA

; Rutina para leer el teclado; configuración inicial

leeTecladoIOConf:

        ; Puerto A de salida
        lda #$ff
        sta CIDDRA

        ; Puerto B de entrada
        lda #$00
        sta CIDDRB

        rts

; Rutina para leer el teclado

filas:   .byte $fe,$fd,$fb,$f7,$ef,$df,$bf,$7f

coordX:  .byte $00
coordY:  .byte $00

leeTecladoIO:

        ; Inicializa la salida
        lda #$ff
        sta coordX
        sta coordY

ltBucle0:

        ; Recorre las filas de la matriz
        ldy #$07

ltBucle1:

        ; Centra la atención en la fila Y
        lda filas,y
        sta CIAPRA

        ; Lee las teclas de la fila Y
        lda CIAPRB

        ; Recorre las columnas de la matriz (bits de CIAPRB)
        ldx #$07

ltBucle2:

        ; Pasa la columna / bit al acarreo
        asl a

        ; Si es 0 es que está pulsada (x,y)
        bcc ltFin

        dex
        bne ltBucle2

        dey
        bne ltBucle1

        ; No se ha detectado ninguna tecla
        ; Hay dos opciones: a) vuelta a empezar, b) terminar

        ;jmp ltBucle0
        rts

ltFin:

        stx coordX
        sty coordY

        rts

; Rutina para convertir de X,Y a Petscii

; Tabla para convertir el resultado X,Y a Petscii

; Nota: algunas combinaciones X,Y, es decir, algunas teclas del C64,
; no está muy claro con qué teclas del PC se activan. Esto es así porque
; estamos usando un emulador (VICE) y no hardware real.

; Todo lo que no sepamos cómo pintar lo pintamos con "." (46)

chars:   .byte 46,46,46,46,46,46,46,46 ;offset  0+x
        .byte 46,87,65,52,90,83,69,46 ;offset  8+x
        .byte 46,82,68,54,67,70,84,88 ;offset 16+x
        .byte 46,89,71,56,66,72,85,86 ;offset 24+x
        .byte 46,73,74,48,77,75,79,78 ;offset 32+x
        .byte 46,80,76,45,46,46,64,44 ;offset 40+x
        .byte 46,46,46,46,58,61,46,46 ;offset 48+x
        .byte 46,46,46,50,32,46,81,46 ;offset 56+x

offset:  .byte 0,8,16,24,32,40,48,56

coordX2: .byte $00
coordY2: .byte $00
petscii: .byte $00

xy2Petscii:

        ; Inicializa el resultado
        lda #46
        sta petscii

        ; Si la coordX es mayor que 7 => fin
        lda coordX2
        cmp #$08
        bcs xy2pFin

        ; Si la coordY es mayor que 7 => fin
        lda coordY2
        cmp #$08
        bcs xy2pFin

        ; Estamos entre 0 y 7

        ; Offset que se deriva de Y
        ldy coordY2
        lda offset,y

        ; Más el offset que se deriva de X
        clc
        adc coordX2

        tax

        ; Lee el carácter de la tabla
        lda chars,x
        sta petscii

xy2pFin:

        rts
