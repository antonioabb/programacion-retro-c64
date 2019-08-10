; Librería de rutinas para operaciones matemáticas

.DATA

; Rutina para sumar dos números de 2 .bytes cada uno

; Rutina para restar dos números de 2 .bytes cada uno

; Rutina para multiplicar un número de 2 .bytes por 2 N veces

multNumLo:       .byte $00
multNumHi:       .byte $00

multVeces:       .byte $00

multResLo:       .byte $00
multResHi:       .byte $00

multiplica2NVeces:

        lda multNumLo
        sta multResLo

        lda multNumHi
        sta multResHi

        ldx multVeces

        beq m2Fin

m2Bucle:

        lda multResLo
        clc
        rol
        sta multResLo

        lda multResHi
        rol ; incluye el acarreo de la parte 'lo' a la 'hi', si existe
        sta multResHi

        dex
        bne m2Bucle

m2Fin:

        rts

; Rutina para dividir un número de 2 .bytes por 2 N veces

divNumLo:        .byte $00
divNumHi:        .byte $00

divVeces:        .byte $00

divResLo:        .byte $00
divResHi:        .byte $00

divide2NVeces:

        lda divNumHi
        sta divResHi

        lda divNumLo
        sta divResLo

        ldx divVeces

        beq d2Fin

d2Bucle:

        lda divResHi
        clc
        ror
        sta divResHi

        lda divResLo
        ror ; incluye el acarreo de la parte 'hi' a la 'lo', si existe
        sta divResLo

        dex
        bne d2Bucle

d2Fin:

        rts
