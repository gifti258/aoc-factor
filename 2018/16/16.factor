using: assocs assocs.extras kernel math math.matrices
math.parser multiline peg.ebnf sequences sets ;
use: prettyprint
in: 2018.16

! Chronal Classification
! part 1: count samples that behave like 3 or more opcodes
! part 2: value in register 0 after executing program

ebnf: (parse) [=[
    n = [0-9]+ => [[ dec> ]]
    ns = (n (", "?)~)+
    in = "Before: ["~ ns "]"~
    out = "After:  ["~ ns "]"~
    instruction = (n (" "?)~)+
    line = in|out|instruction
]=]

: parse ( seq -- samples test-program )
    unclip-last [ 2 head* ] dip
    [ [ (parse) ] matrix-map ] [ [ (parse) ] map ] bi* ;

: (macro) ( quot -- quot ) '[ first3 @ pick set-nth ] ; inline

macro: rr ( quot -- quot )
    '[ [ pick '[ _ nth ] bi@ @ ] dip ] (macro) ;

macro: ri ( quot -- quot )
    '[ [ over nth ] 2dip _ dip ] (macro) ;

macro: ir ( quot -- quot ) '[ [ pick nth @ ] dip ] (macro) ;

: >n ( ? -- n ) 1 0 ? ;

constant: mnemonics {
    [ [ + ] rr ]
    [ [ + ] ri ]
    [ [ * ] rr ]
    [ [ * ] ri ]
    [ [ bitand ] rr ]
    [ [ bitand ] ri ]
    [ [ bitor ] rr ]
    [ [ bitor ] ri ]
    [ [ drop ] rr ]
    [ [ drop ] ir ]
    [ [ > >n ] ir ]
    [ [ > >n ] ri ]
    [ [ > >n ] rr ]
    [ [ = >n ] ir ]
    [ [ = >n ] ri ]
    [ [ = >n ] rr ]
}

: behaves-like? ( sample quot -- ? )
    [ first3 [ rest ] dip ] dip
    '[ [ clone ] dip _ call( in args -- out ) ] dip = ; inline

: part-1 ( samples test-program -- n )
    drop [ mnemonics [ behaves-like? ] with count 3 >= ] count ;

: part-2 ( samples test-program -- n )
    [
        [ v{ } clone h{ } clone ] dip [
            [ mnemonics [ behaves-like? ] with filter ]
            [ second first ] bi pick push-at
        ] each [ intersect-all ] map-values [
            dup assoc-empty?
        ] [
            [ nip length 1 = ] assoc-partition [
                [
                    [ first swap pick set-nth ] assoc-each
                ] keep values concat
            ] dip [ swap diff ] with map-values
        ] until drop { 0 0 0 0 }
    ] dip [
        unclip reach nth call( in args -- out )
    ] each nip first ;
