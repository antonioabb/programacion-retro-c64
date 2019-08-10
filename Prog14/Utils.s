; Fichero con subrutinas de utilidad

.DATA

chrout  = $ffd2 ; Rutina del Kernal para imprimir en pantalla

; Subrutina que imprime en binario el contenido de una palabra

imprimeMem:

        ldx #8          ; el registro X va a recorrer los bits
bucleL:  rol res         ; pasa el bit 7 al acarreo
        lda #0          ; carga el acumulador con 0
        adc #$30        ; si no hay acarreo suma $30; si lo hay $31
        jsr chrout      ; imprime $30=0 o $31=1
        dex             ; pasa a la siguiente iteración / bit
        bne bucleL      ; si no terminado, continúa

        lda #13
        jsr chrout

        rts
