; Rutina para probar bmi/bpl y el flag N o S

.DATA

flagN:

        lda #127
        adc #127        ; Sustituir por otros valores y probar
        bmi pintaNegat  ; cómo funciona el salto condicional

pintaPosit:

        PINTA_CADENA_D positivo ; El ensamblador sustituye esta
        jmp finN                ; llamada por el código de la macro

pintaNegat:

        PINTA_CADENA_D negativo ; Idem

finN:
        rts

; Cadenas

positivo:       .byte "positivo"
                .byte 13, 00

negativo:       .byte "negativo"
                .byte 13, 00
