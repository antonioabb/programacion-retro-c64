; Rutinas del Kernal

.DATA

chrout = $ffd2 ; Rutina del Kernal para imprimir un carácter por pantalla
getin  = $ffe4 ; Rutina del Kernal para leer una carácter del teclado

; Subrutina que imprime el acumulador en hexadecimal

temp1:   .byte $00

imprimeAcum:

        sta temp1       ; Pone a salvo el acumulador para no modificarlo

        lsr             ; Desplaza 4 bits a la derecha para quedarse
        lsr a           ; con el nibble más significativo
        lsr
        lsr a           ; Se puede usar lsr o lsr a

        jsr hexcii      ; Convierte un nibble en su valor ascii

        jsr chrout      ; Imprime el valor ascii del nibble

        lda temp1       ; Recupera el acumulador

        and #%00001111  ; El nibble menos significativo es más
                        ; fácil de obtener con un and

        jsr hexcii      ; Convierte un nibble en su valor ascii

        jsr chrout      ; Imprime el valor ascii del nibble

        lda temp1       ; Recupera el acumulador

        rts             ; Termina

; Subrutina que convierte el nibble menos significativo del
; acumulador en su valor ascii

hexcii:

        cmp #$0a        ; Resta acum - $0a
                        ; acum >= $0a => acarreo => letra a-f
                        ; acum <  $0a => no acarreo => numero 0-9

        bcc numero      ; cmp funciona como una resta
letra:

        adc #$06        ; esto suma $06 y el acarreo, es decir, $07
                        ; y más abajo sumaremos $30; total $37
                        ; de este modo pasamos del valor binario/hex
                        ; de la letra a su código ascii

numero:

        adc #$30        ; esto sólo suma $30
                        ; de este modo pasamos del valor binario/hex
                        ; del número a su código ascii

        rts

; Subrutina que lee un byte del teclado y lo mete en el acumulador

temp2:   .byte $00

leeAcum:

        jsr getin       ; Lee un carácter del teclado
        beq leeAcum     ; Si no hay carácter, sigue leyendo

        tax             ; Pone a salvo el acumulador en X
        jsr chrout      ; Imprime el carácter leído del teclado
        txa             ; Recupera el acumulador desde X

        jsr aschex      ; Convierte el valor ascci a su valor binario
        asl             ; Lo pasa al nibble más significativo
        asl a           ; Lo pasa al nibble más significativo
        asl             ; Lo pasa al nibble más significativo
        asl a           ; Lo pasa al nibble más significativo
        sta temp2       ; Guarda de momento el nibble más significativo

segundo:

        jsr getin       ; Lee el segundo carácter del teclado
        beq segundo     ; Si no hay carácter, sigue leyendo

        tax             ; Pone a salvo el acumulador en X
        jsr chrout      ; Imprime el carácter leído del teclado
        txa             ; Recupera el acumulador desde X

        jsr aschex      ; Convierte el valor ascci a su valor binario
        ora temp2       ; Hace el OR del nibble superior (temp2) y del inf
        rts

; Subrutina que convierte el valor ascii de un dígito hexadecimal
; en un nibble con el valor equivalente

aschex:

        cmp #$40        ; Resta acum - $40
                        ; acum >= $40 => acarreo => letra a-f
                        ; acum <  $40 => no acarreo => numero 0-9

        bcc numero2      ; cmp funciona como una resta
letra2:

        sbc #$07        ; resta $07, más $30 de abajo

numero2:
        sec
        sbc #$30        ; resta $30

        rts
