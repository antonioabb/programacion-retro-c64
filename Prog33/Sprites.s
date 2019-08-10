; Esta forma de utilizar los datos del sprite también es interesante
;
; En vez de exportar los datos mediante directivas "byte" lo que hacemos
; es exportar en formato binario. Luego ponemos una etiqueta (spritePulga)
; para poder referenciar los datos, y los importamos con incbin <fichero>.

.DATA

sprites:
.incbin "Sprites.bin"
