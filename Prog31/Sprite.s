; Esta es la definición del sprite obtenida diseñando el sprite
; en "Sprite Editor" y exportando los datos a directivas ".byte"
; para el ensamblador

.DATA

spritePulga:
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $01,$00,$80
 .byte $00,$81,$00
 .byte $00,$42,$00
 .byte $00,$42,$00
 .byte $00,$5A,$00
 .byte $00,$3C,$00
 .byte $00,$7E,$00
 .byte $00,$5A,$00
 .byte $06,$7E,$60
 .byte $05,$7E,$A0
 .byte $04,$FF,$20
 .byte $02,$7E,$40
 .byte $02,$3C,$40
 .byte $02,$18,$40
 .byte $01,$00,$80
 .byte $01,$00,$80
 .byte $01,$00,$80
 .byte $1F,$00,$F8
 .byte $00 ; Este último .byte es el 64; es "padding" o relleno hasta 64

spriteUnPixel:
 .byte $80,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00,$00,$00
 .byte $00 ; Este último .byte es el 64; es "padding" o relleno hasta 64
