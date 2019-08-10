; Macro que pinta una cadena

.DATA

; Las macros son una construcción del ensamblador, no son
; parte del código máquina del 6510. Las rutinas jsr/rts,
; en cambio, sí son parte del código máquina del 6510.

; Al ensamblar, el ensamblador sustituye cada llamada a la macro
; por una copia de su código/definición. Por tanto, si vemos el
; código máquina no veremos llamadas del tipo jsr, sino que cada
; "llamada" ha sido sustituida por una copia del código.

; Y en cada copia de la macro se sustituyen los parámetros (ej. /1)
; por el valor con que se "llama", en este caso una dirección o
; etiqueta que apunta a una cadena de texto.

chrout = $ffd2

.macro PINTA_CADENA_D arg1    ; La macro empieza por defm y termina endm

        ldx #$00
@bucle: lda arg1,x      ; /1 se refiere al primer parámetro
        beq @fin        ; en este caso la dirección de la cadena
        jsr chrout
        inx
        jmp @bucle      ; Se utiliza @ en las etiquetas para
@fin:                   ; que sean únicas en cada copia
.endmacro
