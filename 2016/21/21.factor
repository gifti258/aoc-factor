using: arrays assocs combinators kernel math
math.parser multiline peg.ebnf sequences sequences.extras ;
in: 2016.21

! Scrambled Letters and Hash
! part 1: get scrambled password
! part 2: unscramble password

symbols: +sp+ +sl+ +l+ +r+ +rs+ +rp+ +rt+ +mp+ ;

ebnf: parse [=[
    n = [0-9]+ => [[ dec> ]]
    a = "swap position "~ n " with position "~ n
        => [[ +sp+ prefix ]]
    b = "swap letter "~ . " with letter "~ .
        => [[ +sl+ prefix ]]
    l = "left"~ => [[ +l+ ]]
    r = "right"~ => [[ +r+ ]]
    c = "rotate "~ (l|r) " "~ n " step"~ ("s"?)~
        => [[ +rs+ prefix ]]
    d = "rotate based on position of letter "~ .:c
        => [[ v{ +rp+ c } ]]
    e = "reverse positions "~ n " through "~ n
        => [[ +rt+ prefix ]]
    f = "move position "~ n " to position "~ n
        => [[ +mp+ prefix ]]
    operation = a|b|c|d|e|f
]=]

: transform ( str str -- str )
    [ clone ] dip parse unclip {
        { +sp+ [ first2 pick exchange ] }
        { +sl+ [ dup reverse 2array substitute ] }
        { +rs+ [ first2 swap +r+ = [ neg ] when rotate ] }
        { +rp+ [
            first over index dup 4 >= [ 1 + ] when 1 + neg
            rotate
        ] }
        { +rt+ [ first2 1 + pick <slice> reverse! drop ] }
        { +mp+ [
            first2
            [ [ swap nth ] [ swap remove-nth ] bi-curry bi ]
            [ swap insert-nth ] bi*
        ] }
    } case ;

: inverse-transform ( str str -- str )
    [ clone ] dip parse unclip {
        { +sp+ [ first2 pick exchange ] }
        { +sl+ [ dup reverse 2array substitute ] }
        { +rs+ [ first2 swap +l+ = [ neg ] when rotate ] }
        { +rp+ [
            first over index { 1 1 6 2 7 3 0 4 } nth rotate
        ] }
        { +rt+ [ first2 1 + pick <slice> reverse! drop ] }
        { +mp+ [
            first2 swap
            [ [ swap nth ] [ swap remove-nth ] bi-curry bi ]
            [ swap insert-nth ] bi*
        ] }
    } case ;

: part-1 ( str -- str ) "abcdefgh" swap [ transform ] each ;

: part-2 ( str -- str )
    "fbgdceah" swap reverse [ inverse-transform ] each ;
