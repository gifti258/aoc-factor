USING: kernel math math.parser peg.ebnf sequences shuffle ;
IN: 2017.15

! Dueling Generators
! Count matching lower 16 bits

: generate ( factor n -- factor n ) dupd * 2147483647 mod ;

:: count ( seq n quot -- n )
    seq
    [ EBNF[[ line = "Generator "~ .~ " starts with "~ [0-9]+ ]]
    dec> ] map first2 [ 16807 swap ] [ 48271 swap ] bi* 0 n [
        quot dip shuffle( a b c d e -- a b c d e b d )
        [ 16 2^ mod ] same? [ 1 + ] when
    ] times 4nip ; inline

: part-1 ( seq -- n ) 40,000,000 [ [ generate ] 2bi@ ] count ;

: part-2 ( seq -- n )
    5,000,000 [
        4 8 [ '[ dup _ mod zero? ] [ generate ] do until ]
        bi-curry@ 2bi*
    ] count ;
