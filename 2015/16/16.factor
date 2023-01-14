using: arrays assocs combinators kernel math math.matrices
math.parser multiline peg.ebnf sequences sets strings ;
in: 2015.16

! Aunt Sue
! Find the aunt that sent you the analysis machine

ebnf: parse [=[
	property = [a-z]+ => [[ >string ]]
	n = [0-9]+ => [[ dec> ]]
	item = property ": "~ n (", "?)~
	rule = ("Sue " n ": ")~ item+
]=]

: parse* ( seq -- seq' ) [ >array ] matrix-map ;

constant: needle {
    { "children" 3 } { "cats" 7 } { "samoyeds" 2 }
    { "pomeranians" 3 } { "akitas" 0 } { "vizslas" 0 }
    { "goldfish" 5 } { "trees" 3 } { "cars" 2 } { "perfumes" 1 }
}

: part-1 ( seq -- n ) [ needle subset? ] find drop 1 + ;

: part-2 ( seq -- n )
    [ [ {
        { [ dup first { "cats" "trees" } in? ] [
            first2 swap needle at [ > ] [ drop f ] if*
        ] }
        { [ dup first { "pomeranians" "goldfish" } in? ] [
            first2 swap needle at [ < ] [ drop f ] if*
        ] }
        [ needle in? ]
    } cond ] all? ] find drop 1 + ;
