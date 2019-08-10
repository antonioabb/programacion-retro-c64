; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/04/19/forma-de-onda-cuadrada-ancho-de-pulso/
; Prog49
;
; Programa para ejemplificar el uso del ancho de pulso
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Mem.s"
.include "ConstSonido.s"
.include "LibSonido.s"
.include "LibTemp.s"

; En CC65 no hace falta definir el cargador
; Cargador BASIC
; 10 SYS49152
; * = $0801
;   .byte    $0B, $08, $0A, $00, $9E, $34, $39, $31, $35, $32, $00, $00, $00
; * = $c000 ; El programa se cargará en 49152

; Incluye cabecera BASIC en $0801
; Posicion de memoria donde carga el programa $080d (2061)

.CODE

Prog49:
        ; Inicializa el SID
        jsr inicializaImagenSID
        jsr transfiereImagenSID

        ; Fija la frecuencia
        lda #$1e
        sta frecLo
        lda #$86
        sta frecHi
        jsr fijaFrecuencia

        ; Fija el volumen
        lda #$0f
        sta volumen
        jsr fijaVolumen

        ; Fija la forma de onda
        lda #Cuadrada
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

        ; Activa la voz 1
        jsr activaVoz
        jsr transfiereImagenSID

        ; Va cambiando el ancho de pulso

        ; Nota: hay características que se pueden cambiar con la voz activa
        ; y otras que no se pueden cambiar; en este caso el ancho de pulso
        ; sí se puede cambiar

        jsr ancho100
        jsr ancho50
        jsr ancho10

        ; Desactiva la voz 1
        jsr desactivaVoz
        jsr transfiereImagenSID

        rts

ancho100:

        ; Fija el ancho de pulso al 100% ($0fff)
        lda #$ff
        sta anchoPulsoLo
        lda #$0f
        sta anchoPulsoHi
        jsr fijaAnchoPulso

        jsr transfiereImagenSID

        ; Espera un tiempo
        lda #$ff
        sta retardoLo
        sta retardoHi
        jsr meteRetardo

        rts

ancho50:

        ; Fija el ancho de pulso al 50% ($0800)
        lda #$00
        sta anchoPulsoLo
        lda #$08
        sta anchoPulsoHi
        jsr fijaAnchoPulso

        jsr transfiereImagenSID

        ; Espera un tiempo
        lda #$ff
        sta retardoLo
        sta retardoHi
        jsr meteRetardo

        rts

ancho10:
        ; Fija el ancho de pulso al 10% ($0029)
        lda #$00
        sta anchoPulsoLo
        lda #$29
        sta anchoPulsoHi
        jsr fijaAnchoPulso

        jsr transfiereImagenSID

        ; Espera un tiempo
        lda #$ff
        sta retardoLo
        sta retardoHi
        jsr meteRetardo

        rts
