; Programa a grabar
; Empieza en $c100=49408 + 2 bytes de cabecera => 49410

; *=$c100
.segment "SUB0"

; Empezamos por la dirección en que queremos que se cargue el programa
; Esta dirección va al fichero bajo la forma de una cabecera y se
; utilizará (opcionalmente, no es obligatorio) al cargar el fichero

pgCabecera:

        .byte    $02, $c1

programaGrabado:

        ; Este es el programa grabado
        ; También se pueden grabar ficheros de datos, no necesariamente progs

        ; Pinta una cadena de texto

        ldx #$00

pgBucle:

        lda pgCadena,x
        beq pgFin
        jsr chrout

        inx

        jmp pgBucle

pgFin:
        rts

pgCadena:   .byte "este es el programa a grabar/grabado..."
            .byte $00

finProgramaGrabado:
