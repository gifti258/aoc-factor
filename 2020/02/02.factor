USING: kernel math math.order math.parser multiline peg.ebnf
sequences ;
IN: 2020.02

! Password Philosophy
! Count valid passwords

: part-1 ( seq -- n )
    [ EBNF[=[
        number = [0-9]+ => [[ dec> ]]
        rule = number:a "-"~ number:b " "~ .:c ":"~ " "~ .+:d
            => [[ d [ c = ] filter length a b between? ]]
    ]=] ] filter length ;

: part-2 ( seq -- n )
    [ EBNF[=[
        number = [0-9]+ => [[ dec> ]]
        rule = number:a "-"~ number:b " "~ .:c ":"~ " "~ .+:d
            => [[ a b [ 1 - d ?nth c = ] bi@ xor ]]
    ]=] ] filter length ;
