using: kernel math math.parser multiline peg.ebnf sequences ;
in: 2017.15

! Dueling Generators
! Count matching lower 16 bits

ebnf: parse [=[
    line = "Generator "~ .~ " starts with "~ [0-9]+
        => [[ dec> ]]
]=]

: generate ( factor n -- factor n ) dupd * 2147483647 mod ;

: count ( seq n quot -- n )
    [ first2 [ 16807 swap ] [ 48271 swap ] bi* 0 ] 2dip '[
        _ dip reach pick [ 16 2^ mod ] same? [ 1 + ] when
    ] times 4nip ; inline

: part-1 ( seq -- n ) 40,000,000 [ [ generate ] 2bi@ ] count ;

: part-2 ( seq -- n )
    5,000,000 [
        4 8 [ '[ dup _ mod zero? ] [ generate ] do until ]
        bi-curry@ 2bi*
    ] count ;
