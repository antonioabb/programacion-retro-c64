; Esto no es un programa propiamente dicho
; Más bien es una colección de constantes relativas a la memoria C64
; Es muy útil tener una referencia así a la hora de programar

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $00-$FF       PAGINA CERO (256 bytes)
 
; $00-$01       Reservado para gestión de memoria
ZeroPageTemp    = $02
; $03-$8F       Reservado para BASIC
; $90-$FA       Reservado para el Kernal
ZeroPageLow     = $FB
ZeroPageHigh    = $FC
ZeroPageLow2    = $FD
ZeroPageHigh2   = $FE
; $FF           Reservado para el Kernal

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $0100-$01FF   PILA (256 bytes)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $0200-$9FFF   RAM (40K)

CINV            = $0314
VICSCN          = $0400
SPRITE0         = $07F8

; $0801-$9FFF   Programas en BASIC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $A000-$BFFF   ROM BASIC(8K)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $C000-$CFFF   RAM (4K)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $D000-$DFFF   ENTRADA/SALIDA(4K)

; A continuación algunos registros de VIC, SID, COLOR RAM y CIAs
; Nombres tomados del libro 'Mapping the Commodore 64'

SP0X            = $D000
SP0Y            = $D001
MSIGX           = $D010
SCROLY          = $D011
RASTER          = $D012
SPENA           = $D015
SCROLX          = $D016
YXPAND          = $D017
VMCSB           = $D018
VICIRQ          = $D019
IRQMSK          = $D01A
SPBGPR          = $D01B
SPMC            = $D01C
XXPAND          = $D01D
SPSPCL          = $D01E
SPBGCL          = $D01F
EXTCOL          = $D020
BGCOL0          = $D021
BGCOL1          = $D022
BGCOL2          = $D023
BGCOL3          = $D024
SPMC0           = $D025
SPMC1           = $D026
SP0COL          = $D027

FRELO1          = $D400 ;(54272)
FREHI1          = $D401 ;(54273)
PWLO1           = $D402 ;(54274)
PWHI1           = $D403 ;(54275)
VCREG1          = $D404 ;(54276)
ATDCY1          = $D405 ;(54277)
SUREL1          = $D406 ;(54278)
FRELO2          = $D407 ;(54279)
FREHI2          = $D408 ;(54280)
PWLO2           = $D409 ;(54281)
PWHI2           = $D40A ;(54282)
VCREG2          = $D40B ;(54283)
ATDCY2          = $D40C ;(54284)
SUREL2          = $D40D ;(54285)
FRELO3          = $D40E ;(54286)
FREHI3          = $D40F ;(54287)
PWLO3           = $D410 ;(54288)
PWHI3           = $D411 ;(54289)
VCREG3          = $D412 ;(54290)
ATDCY3          = $D413 ;(54291)
SUREL3          = $D414 ;(54292)
CUTLO           = $D415 ;(54293)
CUTHI           = $D416 ;(54294)
RESON           = $D417 ;(54295)
SIGVOL          = $D418 ;(54296)
POTX            = $D419 ;(54297)
POTY            = $D41A ;(54298)
RANDOM          = $D41B ;(54299)
ENV3            = $D41C ;(54300)
      
COLORRAM        = $D800

CIAPRA          = $DC00
CIAPRB          = $DC01
CIDDRA          = $DC02
CIDDRB          = $DC03
TIMALO          = $DC04
TIMAHI          = $DC05
TIMBLO          = $DC06
TIMBHI          = $DC07
TODTEN          = $DC08
TODSEC          = $DC09
TODMIN          = $DC0A
TODHRS          = $DC0B
CIASDR          = $DC0C
CIAICR          = $DC0D
CIACRA          = $DC0E
CIACRB          = $DC0F

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $E000-$FFFF   KERNAL (8K) 

SETLFS          = $FFBA
SETNAM          = $FFBD
CHROUT          = $FFD2
SAVE            = $FFD8
GETIN           = $FFE4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
