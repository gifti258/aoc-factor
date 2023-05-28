USING: aoc.input kernel literals math math.parser sequences
sequences.extras sets splitting syntax.terse ;
IN: 2018.21

! Chronal Conversion
! Find input that causes the fewest/most execution steps

CONSTANT: c $[ 8 input-lines nth split-words second dec> ]

: produce-output ( a b -- a b )
    drop 0x10000 `| c swap [
        [ 255 `& + 0xffffff `& 65899 * 0xffffff `& ] keep
        dup 255 > [ [ 8 `>> ] when ] keep
    ] loop ;

: part-1 ( -- n ) 0 0 produce-output drop ;

: part-2 ( -- n )
    f HS{ } clone 0 0 [
        over reach ?adjoin
        [ [ [ rot drop tuck ] dip ] when ] keep
    ] [ produce-output ] do while 3drop ;
