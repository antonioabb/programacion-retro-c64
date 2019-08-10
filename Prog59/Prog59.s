; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/06/23/grabacion-de-ficheros-con-el-kernal/
; Prog59
;
; Programa para ejemplificar la grabación de ficheros
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Mem.s"
.include "ConstText.s"
.include "LibText.s"

.include "MiPrograma.s"

; En CC65 no hace falta definir el cargador
; Cargador BASIC
; 10 SYS49152
; * = $0801
;   .byte    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00
; * = $c000 ; El programa se cargará en 49152

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog59:
        ; Este es el programa que graba
        ; Utiliza la rutina save del Kernal

        ; Vamos a usar disco (8)
        lda #$01
        ldx #$08
        ldy #$01
        jsr SETLFS

        ; Nombre de fichero
        lda #$0a
        ldx #<nombreFichero
        ldy #>nombreFichero
        jsr SETNAM

        ; Grabación del fichero/programa

        ; $fb-$fc es un puntero al comienzo del programa
        ; Incluye la cabecera de 2 bytes para indicar
        ; donde se cargará en el futuro (load)
        lda #<pgCabecera
        sta $fb

        lda #>pgCabecera
        sta $fc

        ; X-Y es un puntero al final del programa
        ldx #<finProgramaGrabado
        ldy #>finProgramaGrabado

        ; A indica dónde está el puntero al comienzo ($fb-$fc)
        lda #$fb

        ; Graba
        clc
        jsr SAVE

        ; Conviene revisar los errores, que vienen en acarreo
        bcc fin

        ; Si C=1, pinta mensaje de error
        sta error
        jsr pintaError

fin:

        ; Vuelve a BASIC
        rts

nombreFichero:   .byte "miprograma" ; Longitud 10=$0a

; Rutina para pintar errores

cadenaError:     .byte "error: "
                 .byte $00
error:           .byte $00

pintaError:

        lda #<cadenaError
        sta cadenaLo

        lda #>cadenaError
        sta cadenaHi

        jsr pintaCadena

        lda error
        sta numeroHex

        jsr pintaHex

        rts
