using: assocs kernel math math.parser multiline
peg.ebnf sequences sets strings ;
in: 2020.07

! Handy Haversacks
! part 1: number of bags that can contain shiny gold bags
! part 2: number of bags contained in a shiny gold bag

ebnf: parse [=[
    color = [a-z]+ " " [a-z]+ => [[ concat >string ]]
    n = [0-9]+ => [[ dec> ]]
    empty = " no other bags." => [[ f ]]
    line = color " bags contain"~
        (empty|(" "~ n " "~ color (" bag" "s"? (","|"."))~)+)
]=]

: part-1 ( seq -- n )
    [ f { "shiny gold" } ] dip [
        [ [ second values intersects? ] with filter keys ] keep
        over empty?
    ] [ [ [ append ] keep ] dip ] until 2drop cardinality ;

: bags ( seq str -- n )
    [ of ] keepd '[ first2 _ swap bags 1 + * ] map-sum ;

: part-2 ( seq -- n ) "shiny gold" bags ;
