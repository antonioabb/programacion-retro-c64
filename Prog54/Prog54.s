; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/05/18/ficheros-sid/
; Prog54
;
; Ejemplo de inclusión y reproducción de un fichero SID descargado de HVSC
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "IncSid.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog54:
        ; Inicializa el fichero SID
        ; La dirección concreta depende del fichero SID descargado
        jsr $c980

        ; Configura la rutina de interrupción
        sei

        lda #<irq
        sta $0314
        lda #>irq
        sta $0315

        cli

        ; Vuelve a BASIC
        rts

; Rutina de interrupción

irq:

        ; Reproduce el fichero SID
        ; La dirección concreta depende del fichero SID descargado
        jsr $ca52

        ; Continúa con la rutina de interrupción del sistema
        jmp $ea31
