USING: kernel math math.parser multiline peg.ebnf sequences ;
IN: 2016.09

! Explosives in Cyberspace
! Decompress strings

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    marker = "("~ n "x"~ n ")"~
    seq = [A-Z]* marker? .*
]=]

: decompress ( str -- str' )
    { } swap [ parse dup second ] [
        first3 [ append ] [ first2 ] [ rot cut ] tri*
        [ <repetition> concat append ] dip
    ] while first append ;

: part-1 ( str -- n ) decompress length ;

: decompress* ( str -- n )
    0 swap [ parse dup second ] [
        first3 [ length + ] [ first2 ] [ rot cut ] tri*
        [ decompress* * + ] dip
    ] while first length + ;

: part-2 ( str -- n ) decompress* ;
