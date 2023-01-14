using: arrays assocs assocs.extras kernel math
math.order math.parser multiline peg.ebnf ranges sequences
strings ;
in: 2015.14

! Reindeer Olympics
! part 1: calculate the winning reindeer's travel distance
! part 2: calculate the winning reindeer's points

ebnf: parse [=[
	reindeer = [a-zA-Z]+ => [[ >string ]]
	number = [0-9]+ => [[ dec> ]]
	rule = reindeer " can fly "~ number " km/s for "~ number
        " seconds, but then must rest for "~ number " seconds."~
]=]

:: distance ( velocity flight rest seconds -- distance )
    seconds flight rest + /mod [ flight * ] [ flight min ] bi* +
    velocity * ;

: part-1 ( seq -- n )
    [ rest first3 2503 distance ] map supremum ;

: winners ( reindeers seconds -- reindeers )
    '[ first4 _ distance 2array ] map dup values supremum
    '[ _ = ] filter-values keys ;

: part-2 ( seq -- n )
    h{ } clone swap 2503 [1..b] [
        winners [ over inc-at ] each
    ] with each values supremum ;
