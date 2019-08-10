; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/05/09/octavas-notas-y-frecuencias/
; Prog51
;
; Programa para ejemplificar la programación de frecuencias en el SID
; a partir de notas y octavas (lo que produce el compositor)
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Mem.s"
.include "ConstSonido.s"
.include "ConstText.s"
.include "ConstMath.s"
.include "LibSonido.s"
.include "LibTemp.s"
.include "LibText.s"
.include "LibMath.s"

; En CC65 no hace falta definir el cargador
; Cargador BASIC
; 10 SYS49152
; * = $0801
;   .byte    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00
; * = $c000 ; El programa se cargará en 49152

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog51:
        ; Configura volumen, onda y ADSR
        jsr configuraVoz

        ; Pinta una cadena como cabecera
        lda #<cadena
        sta cadenaLo
        lda #>cadena
        sta cadenaHi
        jsr pintaCadena

        ; Reproduce la melodía
        jsr reproduceMelodia

        rts

cadena:  .byte "octava - nota - frecuencia"
        .byte 13,$00

configuraVoz:

        ; Inicializa el SID
        jsr inicializaImagenSID
        jsr transfiereImagenSID

        ; Fija el volumen
        lda #$0f
        sta volumen
        jsr fijaVolumen

        ; Fija la forma de onda
        lda #Triangular
        sta formaOnda
        jsr fijaFormaOnda

        ; Fija la envolvemente ADSR
        lda #$03
        sta attack
        lda #$01
        sta decay
        lda #$0b
        sta sustain
        lda #$01
        sta release
        jsr fijaADSR

        rts

reproduceMelodia:

        ; Inicializa Y como contador de octavas / notas
        ldy #$00

rmBucle:

        ; Tenemos 3 melodías
        ; De momento sólo tocamos una
        ; Más adelante podremos tocarlas a la vez, una con cada voz del SID

        ; Lee la octava y la nota
        ; lda tablaMelodia1,y
        ; lda tablaMelodia2,y
        lda tablaMelodia3,y

        ; Si es $ff la melodía ha terminado
        cmp #$ff
        beq rmFin

        ; Separa octava
        sta nota

        and #$f0
        lsr a
        lsr a
        lsr a
        lsr a
        sta octava

        ; Traza para pintar la octava
        sta numeroHex
        jsr pintaHex
        lda #$2d
        jsr chrout

        ; Separa nota
        lda nota
        and #$0f
        sta nota

        ; Traza para pintar la nota
        sta numeroHex
        jsr pintaHex
        lda #$2d
        jsr chrout

        ; Obtiene la frecuencia en función de octava y nota
        jsr obtenFrec

        ; Configura la frecuencia en la imagen del SID
        lda frec2Hi
        sta frecHi

        sta numeroHex
        jsr pintaHex

        lda frec2Lo
        sta frecLo

        sta numeroHex
        jsr pintaHex
        lda #13
        jsr chrout

        jsr fijaFrecuencia

        ; Activa la voz
        jsr activaVoz
        jsr transfiereImagenSID

        ; Espera un tiempo
        ; De momento fijo; más adelante estará en una tabla igual que volumen
        lda #$ff
        sta retardoLo
        sta retardoHi
        jsr meteRetardo

        ; Desactiva la voz
        jsr desactivaVoz
        jsr transfiereImagenSID

        ; Pasa a la siguiente nota
        iny
        jmp rmBucle

rmFin:

        rts

; Diferentes melodías para probar...
; De momento sólo tocamos una (la que elijamos)

; La melodía 1 es una escala en la octava 7
; Nibble alto (octava) a 7 y nibble bajo (nota) subiendo y bajando

tablaMelodia1:   .byte $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7a, $7b
                .byte $7b, $7a, $79, $78, $77, $76, $75, $74, $73, $72, $71, $70
                .byte $ff

; La melodía 2 es una escala en la octava 0
; Nibble alto (octava) a 0 y nibble bajo (nota) subiendo y bajando

tablaMelodia2:   .byte $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b
                .byte $0b, $0a, $09, $08, $07, $06, $05, $04, $03, $02, $01, $00
                .byte $ff

; Melodía 3
; Nibble alto (octava) subiendo y bajando y nibble bajo (nota) a 0 = Cx = do

tablaMelodia3:   .byte $00, $10, $20, $30, $40, $50, $60, $70
                .byte $70, $60, $50, $40, $30, $20, $10, $00
                .byte $ff
