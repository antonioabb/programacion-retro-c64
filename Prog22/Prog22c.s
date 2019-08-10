; * = $c200 ; 49664
.segment "SUB1"

nuevaSubrutina:

        ; Desde una subrutina se puede llamar a otra subrutina
        lda #$03
        sta char
        jsr pintaPantalla

        ; Y también se puede usar una macro
        PINTA_PANTALLA_V 4

        rts
