; En este fichero ponemos todo lo relativo a las interrupciones
; para facilitar su lectura

inicializaInterrupciones:

        sei

        lda #%00000100  ; Colisiones entre sprites
        sta IRQMSK

        lda #<rutinaInterrupcion
        sta CINV

        lda #>rutinaInterrupcion
        sta CINV+1

        cli

        rts

rutinaInterrupcion:

        lda VICIRQ

        and #%00000100  ; Colisiones entre sprites
        beq otra

        lda SPSPCL

        lda numColis
        sed
        clc
        adc #$01
        cld
        sta numColis

        pla
        tay

        pla
        tax

        pla

        rti

otra:    jmp $ea31
