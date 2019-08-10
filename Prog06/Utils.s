; Fichero con subrutinas de utilidad

.DATA

chrout  = $ffd2 ; Rutina del Kernal para imprimir en pantalla

; Subrutina que imprime los nombres de los flags

flags:  .byte "nv-bdizc"
        .byte 0

imprimeTit:
        ldx #$00        ; el registro X hace de índice
bucle1: lda flags,x     ; carga el carácter X-esimo en el acumulador
        beq fin         ; si es 0, salta al final
        jsr chrout      ; imprime el carácter X
        inx             ; incrementa el índice X
        jmp bucle1      ; vuelve al comienzo del bucle
fin:    lda #13         ; carga retorno de carro
        jsr chrout      ; imprime retorno de carro
        rts

; Subrutina que imprime el contenido del acumulador en binario

backup:  .byte $00
trabajo: .byte $00

imprimeAcum:
        sta backup      ; resguarda el acumulador para recuperar
        sta trabajo     ; posición de trabajo
        ldx #8          ; el registro X va a recorrer los bits
bucle2: rol trabajo     ; pasa el bit 7 al acarreo
        lda #0          ; carga el acumulador con 0
        adc #$30        ; si no hay acarreo suma $30; si lo hay $31
        jsr chrout      ; imprime $30=0 o $31=1
        dex             ; pasa a la siguiente iteración / bit
        bne bucle2      ; si no terminado, continúa
        lda #13         ; carga retorno de carro
        jsr chrout      ; imprime retorno de carro
        lda backup      ; recupera el valor original
        rts
