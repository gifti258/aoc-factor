using: accessors classes.tuple deques dlists kernel math
math.functions math.parser math.matrices math.statistics
multiline peg.ebnf sequences slots.syntax ;
in: 2022.11

! Monkey in the Middle
! Product of two highest item handling numbers

ebnf: (parse) [=[
    n = [0-9]+ => [[ dec> ]]
    monkey = "Monkey "~ n~ ":"~
    starting-items = "  Starting items: "~ (n (", "?)~)+
    plus = "+ "~ n => [[ '[ _ + ] ]]
    times = "* "~ n => [[ '[ _ * ] ]]
    square = "* old"~ => [[ [ sq ] ]]
    operation = "  Operation: new = old "~ (plus|times|square)
    test = "  Test: divisible by "~ n
    throw = "    If "~ ("true"|"false")~ ": throw to monkey "~ n
    line = monkey|starting-items|operation|test|throw
]=]

tuple: monkey items operation test true false n ;

: parse ( seq -- seq )
    [ (parse) ] matrix-map [
        rest 0 suffix monkey slots>tuple
        [ <dlist> [ push-all-front ] keep ] change-items
    ] map ;

macro: (part) ( n quot -- n )
    '[ _ over [ test>> ] [ lcm ] map-reduce _ '[
        dup [
            dup items>> [
                over get[ operation test true false ] [
                    [ call( x -- x ) _ mod @ dup ]
                    [ divisor? ] bi*
                ] 2dip ? reach [
                    [ [ push-front ] keep ] change-items
                ] change-nth [ 1 + ] change-n
            ] slurp-deque
        ] map nip
    ] times [ n>> ] map { 0 1 } kth-largests product ] ;

: part-1 ( seq -- n ) 20 [ 3 /i ] (part) ;

: part-2 ( seq -- n ) 10,000 [ ] (part) ;
