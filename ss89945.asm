.ORIG x3000
LOADING_TIME        LDI R0,  LOCATION ;R0 contains the value stored at x3300
                    LD  R1, BITMASK_RIGHT ;R1 contains the mask of xFF00
                    LD  R2, BITMASK_LEFT  ;R2 contains the mask of x00FF

MASKING_TIME        AND R3, R0, R1        ;R3 contains R0 bitmasked (AND) with xFF00
                    AND R4, R0, R2        ;R4 contains R0 bitmasked (AND) with x00FF

RIGHT_SHIFT_8_bits AND R6, R6, #0
                   ADD R6, R6, #8
                   ADD R5, R3, R3        ;derived from ADD R1, R0, R0 (left shifts by 1-bit)
                   ADD R3, R3, #0 ; Does nothing but updates CC based on R0
                   BRzp #1
                   ADD R5, R5, #1
                   ADD R3, R5, #0
                   ADD R6, R6, #-1
                   BRp #-7

ADDING_TIME        ADD R7, R4, R5
STORING_TIME       STI R7, STORE_LOCATION
HALT
LOCATION .FILL x3300
BITMASK_RIGHT .FILL xFF00
BITMASK_LEFT  .FILL x00FF
STORE_LOCATION  .FILL x3301
.END