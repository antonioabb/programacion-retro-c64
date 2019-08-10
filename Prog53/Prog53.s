; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/05/14/duracion-y-volumen/
; Prog53
;
; Programa para ejemplificar la programación de duraciones y volúmenes en el SID
; a partir de una tabla con la información de las melodías
;

;.include "c64.inc"               ; Define las constantes del Commodore 64. No es necesario
.include "../Common/charmap.inc"  ; Conversion de caracteres. Necesario

.include "Mem.s"
.include "ConstSonido.s"
.include "ConstText.s"
.include "ConstMath.s"
.include "LibSonido.s"
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

Prog53:
        ; Configura volumen, onda y ADSR
        jsr configuraVoces

        ; Pinta unas cadenas como cabecera
        lda #<cadena1
        sta cadenaLo
        lda #>cadena1
        sta cadenaHi
        jsr pintaCadena
        jsr pintaCadena
        jsr pintaCadena

        lda #<cadena2
        sta cadenaLo
        lda #>cadena2
        sta cadenaHi
        jsr pintaCadena

        ; Reproduce la melodía
        jsr reproduceMelodia

        rts

cadena1: .byte "voz-oct-nota-frec"
        .byte 13, $00

cadena2: .byte "dur-vol"
        .byte 13, 13, $00

configuraVoces:

        ; Inicializa el SID
        jsr inicializaImagenSID
        jsr transfiereImagenSID

        ; Esto ya no es necesario
        ; El volumen saldrá de la tabla más adelante

        ; Fija el volumen
        ;lda #$0f
        ;sta volumen
        ;jsr fijaVolumen

        ; Configura las 3 voces
        jsr configuraVoz1
        jsr configuraVoz2
        jsr configuraVoz3

        rts

configuraVoz1:

        ; Fija la forma de onda
        lda #Triangular
        sta formaOnda
        lda #Voz1
        sta ffoVoz
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
        lda #Voz1
        sta faVoz
        jsr fijaADSR

        rts

configuraVoz2:

        ; Fija la forma de onda
        lda #Rampa
        sta formaOnda
        lda #Voz2
        sta ffoVoz
        jsr fijaFormaOnda

        ; Fija la envolvemente ADSR
        lda #$08
        sta attack
        lda #$03
        sta decay
        lda #$0a
        sta sustain
        lda #$03
        sta release
        lda #Voz2
        sta faVoz
        jsr fijaADSR

        rts

configuraVoz3:

        ; Fija la forma de onda
        lda #Cuadrada
        sta formaOnda
        lda #Voz3
        sta ffoVoz
        jsr fijaFormaOnda

        ; Fija el ancho de pulso
        lda #$00
        sta anchoPulsoLo
        lda #$09
        sta anchoPulsoHi
        lda #Voz3
        sta fapVoz
        jsr fijaAnchoPulso

        ; Fija la envolvemente ADSR
        lda #$03
        sta attack
        lda #$08
        sta decay
        lda #$04
        sta sustain
        lda #$08
        sta release
        lda #Voz3
        sta faVoz
        jsr fijaADSR

        rts

reproduceMelodia:

        ; Usamos el modo indirecto-indexado porque la tabla
        ; con la melodía puede tener más de 256 posiciones

        ; Inicializa el puntero a la tabla
        lda #<tablaMelodia
        sta $fb
        lda #>tablaMelodia
        sta $fc

        ; Inicializa Y a 0 para usar ($fb),y
        ldy #$00

rmBucle:

        ; Tenemos una melodía con 3 voces

        ; Lee la octava y la nota X 1
        lda ($fb),y

        ; Si es $ff la melodía ha terminado
        cmp #$ff
        bne rmCont

        jmp rmFin

rmCont:

        ; Configura la frecuencia
        sta octavaNota
        lda #Voz1
        sta cfrecVoz
        jsr configuraFrecuencia

        ; Lee la octava y la nota X 2
        jsr incPuntero

        lda ($fb),y

        ; Si es $ff la melodía ha terminado
        ;cmp #$ff
        ;beq rmFin

        ; Configura la frecuencia
        sta octavaNota
        lda #Voz2
        sta cfrecVoz
        jsr configuraFrecuencia

        ; Lee la octava y la nota X 3
        jsr incPuntero

        lda ($fb),y

        ; Si es $ff la melodía ha terminado
        ;cmp #$ff
        ;beq rmFin

        ; Configura la frecuencia
        sta octavaNota
        lda #Voz3
        sta cfrecVoz
        jsr configuraFrecuencia

        ; Lee la duración y el volumen
        jsr incPuntero

        lda ($fb),y

        ; Configura el volumen
        sta durVol
        jsr configuraDurVol

        ; Activa las 3 voces
        lda #Voz1
        sta avVoz
        jsr activaVoz

        lda #Voz2
        sta avVoz
        jsr activaVoz

        lda #Voz3
        sta avVoz
        jsr activaVoz

        jsr transfiereImagenSID

        ; Espera un tiempo
        ; Ya no es fijo, sino que sale de la tabla
        lda duracion
        sta numIter

        lda #100 ; 100 milisegundos por iteración; por tanto negra = 0,4 segs
        sta numMilis

        jsr duracionNota

        ;lda #$ff
        ;sta retardoLo
        ;sta retardoHi
        ;jsr meteRetardo

        ; Desactiva las 3 voces
        lda #Voz1
        sta dvVoz
        jsr desactivaVoz

        lda #Voz2
        sta dvVoz
        jsr desactivaVoz

        lda #Voz3
        sta dvVoz
        jsr desactivaVoz

        jsr transfiereImagenSID

        ; Pasa a la siguiente nota
        jsr incPuntero

        jmp rmBucle

rmFin:

        rts

; Rutina para incrementar el puntero

incPuntero:

        lda $fb

        clc
        adc #$01
        sta $fb

        lda $fc
        adc #$00 ; tiene en cuenta el acarreo de $fb
        sta $fc

        rts

; Rutina para configurar la frecuencia a partir de la octava y nota

octavaNota:      .byte $00
cfrecVoz:        .byte $00

configuraFrecuencia:

        ; Traza para pintar la voz
        lda cfrecVoz
        sta numeroHex
        jsr pintaHex
        lda #$2d
        jsr chrout

        ; Separa octava
        lda octavaNota
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

        lda cfrecVoz
        sta ffVoz

        jsr fijaFrecuencia

        rts

; Rutina para configurar duración y volumen

durVol:          .byte $00
duracion:        .byte $00

configuraDurVol:

        ; Separa duración
        lda durVol
        sta volumen

        and #$f0
        lsr a
        lsr a
        lsr a
        lsr a
        sta duracion

        ; Traza para pintar la duración
        sta numeroHex
        jsr pintaHex
        lda #$2d
        jsr chrout

        ; Separa volumen
        lda volumen
        and #$0f
        sta volumen

        ; Traza para pintar el volumen
        sta numeroHex
        jsr pintaHex
        lda #13
        jsr chrout

        ; Fija el volumen
        jsr fijaVolumen

        rts

; Melodía con 3 voces
; Libro De Jong páginas 198-199

tablaMelodia:

        .byte $40,$40,$50,$4f,$35,$30,$45,$6f
        .byte $35,$30,$47,$2f,$35,$30,$49,$4e
        .byte $39,$35,$45,$4f,$37,$34,$40,$6f
        .byte $35,$32,$40,$2f,$37,$34,$40,$4f
        .byte $39,$34,$40,$4f,$35,$49,$45,$6f
        .byte $35,$49,$45,$2f,$39,$35,$45,$4f
        .byte $20,$35,$45,$4f,$22,$35,$4a,$cf
        .byte $22,$35,$4a,$4f,$20,$35,$49,$6f
        .byte $39,$35,$45,$2f,$39,$35,$45,$4f
        .byte $35,$49,$45,$4f,$37,$34,$40,$6f
        .byte $35,$32,$40,$2f,$37,$34,$40,$4f
        .byte $39,$34,$40,$4f,$35,$32,$45,$6f
        .byte $32,$49,$42,$2f,$32,$4a,$5a,$4f
        .byte $30,$4a,$40,$4f,$35,$49,$55,$cf
        .byte $45,$35,$22,$4f,$45,$35,$20,$6f
        .byte $40,$30,$39,$2f,$45,$35,$39,$4f
        .byte $59,$35,$69,$4f,$40,$34,$37,$6f
        .byte $40,$32,$35,$2f,$40,$34,$37,$4f
        .byte $40,$34,$22,$4f,$45,$35,$20,$6f
        .byte $40,$30,$39,$2f,$45,$35,$39,$4f
        .byte $49,$30,$59,$4e,$4a,$35,$32,$cf
        .byte $4a,$35,$25,$4f,$49,$35,$20,$6f
        .byte $45,$35,$39,$2f,$45,$35,$39,$4f
        .byte $59,$30,$35,$4f,$40,$34,$37,$6f
        .byte $40,$32,$35,$2f,$40,$34,$37,$4f
        .byte $41,$34,$39,$2f,$41,$49,$37,$2f
        .byte $42,$32,$35,$6c,$45,$49,$32,$2c
        .byte $5a,$4a,$32,$4d,$40,$44,$30,$4f
        .byte $55,$45,$35,$ff,$55,$45,$35,$c0
        .byte $ff
