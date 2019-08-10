; Programación Retro del Commodore 64
; https://programacion-retro-c64.blog/2019/05/09/octavas-notas-y-frecuencias/
; Prog52
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

Prog52:
        ; Configura volumen, onda y ADSR
        jsr configuraVoces

        ; Pinta una cadena como cabecera
        lda #<cadena
        sta cadenaLo
        lda #>cadena
        sta cadenaHi
        jsr pintaCadena

        ; Reproduce la melodía
        jsr reproduceMelodia

        rts

cadena:   .byte "voz-octava-nota-frecuencia"
          .byte 13,$00

configuraVoces:

        ; Inicializa el SID
        jsr inicializaImagenSID
        jsr transfiereImagenSID

        ; Fija el volumen
        lda #$0f
        sta volumen
        jsr fijaVolumen

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

        ; Inicializa Y como contador de octavas / notas
        ldy #$00

rmBucle:

        ; Tenemos 1 melodía con 3 voces

        ; Lee la octava y la nota X 1
        lda tablaMelodia,y

        ; Si es $ff la melodía ha terminado
        cmp #$ff
        beq rmFin

        ; Configura la frecuencia
        sta octavaNota
        lda #Voz1
        sta cfrecVoz
        jsr configuraFrecuencia

        ; Lee la octava y la nota X 2
        iny
        lda tablaMelodia,y

        ; Si es $ff la melodía ha terminado
        cmp #$ff
        beq rmFin

        ; Configura la frecuencia
        sta octavaNota
        lda #Voz2
        sta cfrecVoz
        jsr configuraFrecuencia

        ; Lee la octava y la nota X 3
        iny
        lda tablaMelodia,y

        ; Si es $ff la melodía ha terminado
        cmp #$ff
        beq rmFin

        ; Configura la frecuencia
        sta octavaNota
        lda #Voz3
        sta cfrecVoz
        jsr configuraFrecuencia

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
        ; De momento fijo; más adelante estará en una tabla igual que volumen
        lda #$ff
        sta retardoLo
        sta retardoHi
        jsr meteRetardo

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
        iny
        jmp rmBucle

rmFin:

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

; Melodía con 3 voces
; Libro De Jong páginas 198-199

tablaMelodia:

        .byte $40,$40,$50,$35,$30,$45
        .byte $35,$30,$47,$35,$30,$49
        .byte $39,$35,$45,$37,$34,$40
        .byte $35,$32,$40,$37,$34,$40
        .byte $39,$34,$40,$35,$49,$45
        .byte $35,$49,$45,$39,$35,$45
        .byte $20,$35,$45,$22,$35,$4a
        .byte $22,$35,$4a,$20,$35,$49
        .byte $39,$35,$45,$39,$35,$45
        .byte $35,$49,$45,$37,$34,$40
        .byte $35,$32,$40,$37,$34,$40
        .byte $39,$34,$40,$35,$32,$45
        .byte $32,$49,$42,$32,$4a,$5a
        .byte $30,$4a,$40,$35,$49,$55
        .byte $45,$35,$22,$45,$35,$20
        .byte $40,$30,$39,$45,$35,$39
        .byte $59,$35,$69,$40,$34,$37
        .byte $40,$32,$35,$40,$34,$37
        .byte $40,$34,$22,$45,$35,$20
        .byte $40,$30,$39,$45,$35,$39
        .byte $49,$30,$59,$4a,$35,$32
        .byte $4a,$35,$25,$49,$35,$20
        .byte $45,$35,$39,$45,$35,$39
        .byte $59,$30,$35,$40,$34,$37
        .byte $40,$32,$35,$40,$34,$37
        .byte $41,$34,$39,$41,$49,$37
        .byte $42,$32,$35,$45,$49,$32
        .byte $5a,$4a,$32,$40,$44,$30
        .byte $55,$45,$35,$55,$45,$35
        .byte $ff
