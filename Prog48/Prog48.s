; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/04/16/los-registros-del-sid/
; Prog48
;
; Programa para hacer un uso básico del SID: volumen, frecuencia y activar nota
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

Prog48:
        ; Inicializa el SID
        jsr inicializaImagenSID
        jsr transfiereImagenSID

        ; Fija la frecuencia
        lda #$1e
        sta freclo
        lda #$86
        sta frechi
        jsr fijaFrecuencia

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

        ; Activa la voz 1
        jsr activaVoz
        jsr transfiereImagenSID

        ; Espera un tiempo
        lda #$ff
        sta retardoLo
        sta retardoHi
        jsr meteRetardo

        ; Desactiva la voz 1
        jsr desactivaVoz
        jsr transfiereImagenSID

        rts
