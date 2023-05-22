USING: aoc.md5 kernel math math.parser sequences ;
IN: 2015.04

! The Ideal Stocking Stuffer
! Find md5 hashes with 5 or 6 leading zeroes

:: find-prefix ( str prefix-length -- n )
    0 [
        1 + str over >dec append checksum
        prefix-length head [ CHAR: 0 = ] all? not
    ] loop ;

: part-1 ( str -- n ) 5 find-prefix ;

: part-2 ( str -- n ) 6 find-prefix ;
