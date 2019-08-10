; Rutina para imprimir un número en binario
; El número debe estar en la posición 'numero'

.DATA

; Rutina del Kernal para imprimir un carácter
chrout = $ffd2

; Esta rutina, como cualquier otra, puede modificar los registros
; del microprocesador. Si interesa no modificarlos habrá que tomar
; medidas, por ejemplo, guardando en acumulador (y/o otros registros)
; al comenzar y recuperándolos al terminar

imprime:

        pha             ; Guarda el acumulador
        ldx #$08        ; Impresión en binario: 8 bits
bucle:  rol numero      ; Va pasando el bit 7 al acarreo
        lda #$00
        adc #$30        ; Suma $30 (0) o $31 (1) en función del acarreo
        jsr chrout      ; Imprime 0 o 1, según bit 7/acarreo
        dex             ; Siguiente bit
        bne bucle       ; Terminado?
        lda #13         ; Imprime retorno de carro
        jsr chrout
        pla             ; Recupera el acumulador
        rts

numero: .byte $00
