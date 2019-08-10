; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/02/20/scroll-horizontal-y-vertical/
; Prog46
;
; Programa para ejemplificar el uso de scroll
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Mem.s"
.include "ConstJoy.s"
.include "LibJoy.s"
.include "LibSCroll.s"
.include "LibTemp.s"

char_a: .byte "A"
char_b: .byte "B"

; En CC65 no hace falta definir el cargador
; Cargador BASIC
; 10 SYS49152
; * = $0801
;   .byte    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00
; * = $c000 ; El programa se cargará en 49152

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog46:
        jsr inicializaPantalla
        jsr activa38Columnas
        jsr fijaScrollXMin

bucle:

        jsr retarda
        jsr actualizaOffset
        jsr controlaSalto
        jsr actualizaScrollX
        jmp bucle

; Variables

mensaje: .byte "ABABABABABABABABABABABABABABABABABABABAB"
         .byte $00

offsetX: .byte $00

; Rutinas

inicializaPantalla:

        lda #147
        jsr $ffd2

        ldx #$00

ipBucle:

        lda mensaje,x

        beq ipFin

        sta VICSCN,x
        inx

        jmp ipBucle

ipFin:

        rts

fijaScrollXMin:

        lda #$00
        sta offsetX

        sta fsX
        jsr fijaScrollX

        rts

actualizaOffset:

        ; Lee el joystick A
        jsr leeJoystickA

        ; Hay movimiento?
        lda joyA
        cmp #Nada
        beq aoFin

        ; Calcula el nuevo offset

aoIzda:

        lda #Izquierda
        bit joyA
        bne aoDcha

;        lda offsetX
;        cmp #%00000111
;        beq aoDcha

        inc offsetX

aoDcha:

        lda #Derecha
        bit joyA
        bne aoFin

;        lda offsetX
;        cmp #%00000000
;        beq aoFin

        dec offsetX

aoFin:

        rts

controlaSalto:

csDerecha:

        lda offsetX
        cmp #%00001000
        bne csIzquierda

        jsr copiaDerecha

        lda #%00000000
        sta offsetX

        jsr nuevoDatoIzquierda

        jmp csFin

csIzquierda:

        lda offsetX
        cmp #%11111111
        bne csFin

        jsr copiaIzquierda

        lda #%00000111
        sta offsetX

        jsr nuevoDatoDerecha

csFin:

        rts

actualizaScrollX:

        lda offsetX
        sta fsX

        jsr fijaScrollX

        rts

retarda:

        lda #250
        sta retRaster

        jsr meteRetardoRaster

        rts

nuevoDatoIzquierda:

        lda VICSCN+0
        cmp char_a
        bne ndiA

        lda char_b
        sta VICSCN+0

        jmp ndiFin

ndiA:

        lda char_a
        sta VICSCN+0

ndiFin:

        rts

nuevoDatoDerecha:

        lda VICSCN+39
        cmp char_a
        bne nddA

        lda char_b
        sta VICSCN+39

        jmp nddFin

nddA:

        lda char_a
        sta VICSCN+39

nddFin:

        rts
