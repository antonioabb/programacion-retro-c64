; Librería de rutinas para manejar el joystick

.DATA

; Rutina para leer el joystick A

joyA:    .byte $00

leeJoystickA:

        lda CIAPRA
        and #Mascara
        sta joyA

        rts

; Rutina para leer el joystick B

joyB:    .byte $00

leeJoystickB:

        lda CIAPRB
        and #Mascara
        sta joyB

        rts
