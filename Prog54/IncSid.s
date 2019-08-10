; * = $c800
.segment "SID"

; La directiva incbin incluye el fichero indicado en la posición indicada

; El número después de la coma indica el número de bytes al comienzo del
; fichero que no se cargan; hay que descartar 126 bytes porque los ficheros
; SID tienen una cabecera que es útil para los reproductores SID, pero que no
; se necesita si el fichero se incluye en un programa

.incbin "Booga-Boo_the_Flea.sid",126
