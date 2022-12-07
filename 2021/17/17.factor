USING: accessors aoc.input kernel math math.functions math.order
math.parser math.quadratic multiline peg.ebnf ranges sequences
words.constant ;
IN: 2021.17

EBNF: parse [=[
    n = [-0-9]+ => [[ dec> ]]
    range = n ".."~ n
    ranges = "target area: x="~ range ", y="~ range
        => [[ concat ]]
]=]

<<
SYMBOLS: xmin xmax ymin ymax ;
{ xmin xmax ymin ymax }
input-line parse
[ define-constant ] 2each
>>

TUPLE: state sx sy vx vy ;

: step ( state -- state )
    dup vx>> '[ _ + ] change-sx
    dup vy>> '[ _ + ] change-sy
    [ 1 [-] ] change-vx
    [ 1 - ] change-vy ;

: hit? ( state -- ? state )
    [ step dup
        [ [ sx>> xmin < ] [ sy>> ymax > ] bi or ]
        [ [ sx>> xmax > ] [ sy>> ymin < ] bi or not ] bi and
    ] loop dup [
        [ sx>> xmin xmax between? ]
        [ sy>> ymin ymax between? ] bi and
    ] dip ;

: iterate ( vx0 -- seq )
    ymin swap '[
        0 0 _ reach state boa hit?
        [ sy>> 0 < ]
        [ vx>> zero? not ]
        [ vy>> ymin 1 - >= ] tri or and
    ] [ [ dup ] [ f ] if [ 1 + ] dip ] produce 2nip sift ;

: part-1 ( -- n ) ymin neg 1 - [1..b] sum ;

: part-2 ( -- n )
    xmin -2 * 1 1 quadratic max ceiling >integer
    xmax [a..b] [ iterate length ] map-sum ;
