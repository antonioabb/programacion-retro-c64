;
; Corregir la conversion de caracteres en cadenas de texto
;
; Cuando se usa el modo C64, convierte los caracteres PETSCII para la memoria
; de pantalla, así puedes escribir directamente a la memoria de pantalla
;
; Char $40 ... $5F -> c-64 -> A-Z
.repeat $20, i
  .charmap $40 + i, i + $00
.endrepeat
