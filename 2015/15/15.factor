USING: kernel math.combinatorics math.matrices
math.order math.parser math.vectors multiline peg.ebnf ranges
sequences ;
IN: 2015.15

! Science for Hungry People
! Find the highest-scoring cookie
! part 2: … with exactly 500 calories

EBNF: parse [=[
    n = [-0-9]+ => [[ dec> ]]
    ingredient = ([A-Za-z]+)~ ": capacity "~ n ", durability "~
        n ", flavor "~ n ", texture "~ n ", calories "~ n
]=]

: find-maximum ( seq quot -- n )
    [ 100 [0..b] 3 0 ] dip '[
        dup [ 100 suffix ] [ 0 prefix ] bi* v- pick vdotm
        unclip-last [ [ 0 max ] map product ] dip @ max
    ] reduce-combinations-with-replacement nip ; inline

: part-1 ( seq -- n ) [ drop ] find-maximum ;

: part-2 ( seq -- n ) [ 500 = [ drop 0 ] unless ] find-maximum ;
