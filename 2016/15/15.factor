USING: kernel math math.algebra math.parser multiline peg.ebnf
sequences ;
IN: 2016.15

! Timing is Everything
! Calculate first time the button can be pressed

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    rule = "Disc #"~ n " has "~ n
        " positions; at time=0, it is at position "~ n "."~
]=]

: part-1 ( seq -- n )
    [ [ [ first ] [ third ] bi + neg ] map ]
    [ [ second ] map ] bi chinese-remainder ;

: part-2 ( seq -- n ) { 7 11 0 } suffix part-1 ;
