USING: kernel math math.order math.parser multiline peg.ebnf
sequences ;
IN: 2020.02

! Password Philosophy
! Count valid passwords

EBNF: parse [=[
    number = [0-9]+ => [[ dec> ]]
    rule = number:a "-"~ number:b " "~ .:c ":"~ " "~ .+:d
        => [[ d [ c = ] filter length a b between? ]]
]=]

EBNF: parse* [=[
    number = [0-9]+ => [[ dec> ]]
    rule = number:a "-"~ number:b " "~ .:c ":"~ " "~ .+:d
        => [[ a b [ 1 - d ?nth c = ] bi@ xor ]]
]=]

: part-1 ( seq -- n ) [ parse ] count ;

: part-2 ( seq -- n ) [ parse* ] count ;
