; Librería de rutinas para manejar el joystick

.DATA

; Rutina para leer el joystick 1

joy1:    .byte $00

leeJoystick1:

        lda CIAPRB
        and #Mascara
        sta joy1

        rts

; Rutina para leer el joystick 2

joy2:    .byte $00

leeJoystick2:

        lda CIAPRA
        and #Mascara
        sta joy2

        rts
