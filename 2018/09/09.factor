USING: accessors assocs deques dlists kernel math math.functions
math.parser math.vectors multiline peg.ebnf sequences
slots.syntax ;
IN: 2018.09

! Marble Mania
! Calculate the winning elf's score

TUPLE: state #players last-marble points marbles cur-marble
    cur-player ;

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    input = n " players; last marble is worth "~ n " points"~
]=]

: part-1 ( seq -- n )
    first2 H{ } clone DL{ 0 } clone 1 1 state boa
    [ dup get[ cur-marble last-marble ] <= ] [
        dup cur-marble>> 23 divisor? [
            dup get[ cur-marble cur-player points ] at+
            dup marbles>> 7 [
                [ pop-front ] keep [ push-back ] keep
            ] times pop-front
            over get[ cur-player points ] at+
            dup marbles>> [ pop-back ] keep push-front
        ] [
            dup marbles>> [ pop-back ] keep push-front
            dup get[ cur-marble marbles ] push-front
        ] if [ 1 + ] change-cur-marble
        [ #players>> ] keep [ swap mod 1 + ] change-cur-player
    ] while points>> values supremum ;

: part-2 ( seq -- n ) { 1 100 } v* part-1 ;
