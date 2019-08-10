; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2018/11/21/instrucciones-para-operaciones-aritmeticas-resta/
; Prog14
;
; Progama para ejemplificar la resta monobyte con sbc
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Utils.s"

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

char_c: .byte "c"
char_equal: .byte "="
char_0: .byte "0"
char_1: .byte "1"

Prog13:
        ; Realiza la resta minuendo - sustraendo

        sec             ; Activa el acarreo
        lda min         ; Carga el minuendo
        sbc sus         ; Resta el sustraendo
        sta res         ; Guarda la resta

        bcc cDesact

cAct:
        lda char_c
        jsr chrout
        lda char_equal
        jsr chrout
        lda char_1        ; Imprime C=1
        jsr chrout
        lda #13
        jsr chrout
        jmp fin

cDesact:

        lda char_c
        jsr chrout
        lda char_equal
        jsr chrout
        lda char_0        ; Imprime C=0
        jsr chrout
        lda #13
        jsr chrout

fin:

        jsr imprimeMem  ; Imprime la resta

        rts             ; Vuelve a BASIC

; Variables

min:     .byte $f0 ; Probar a cambiar sus valores
sus:     .byte $ff ; Probar a cambiar sus valores

res:     .byte $00
