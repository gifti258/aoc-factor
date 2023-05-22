USING: accessors arrays classes.tuple combinators formatting
kernel math math.parser multiline peg.ebnf sequences
sequences.extras slots.syntax ;
IN: 2021.16

! Packet decoder
! part 1: packet version sum
! part 2: evaluate expression

TUPLE: packet
    { version fixnum }
    { type fixnum }
    { content maybe{ boolean fixnum } }
    { length fixnum } ;

EBNF: (parse) [=[
    3bits = ... => [[ bin> ]]
    not-last = ("1"~ ....)* => [[ concat ]]
    last = "0"~ ....
    literal = not-last (last)
        => [[ concat [ bin> ] keep length 4 / 5 * 6 + 2array ]]
    total-length = "0" => [[ f ]] ............... => [[ bin> ]]
    number-of-packets = "1" => [[ t ]] ........... => [[ bin> ]]
    length = total-length|number-of-packets
    literal-packet = (3bits &("100") 3bits) literal
    operator-packet = (3bits !("100") 3bits) length
    packet = (literal-packet|operator-packet)
        => [[ concat packet slots>tuple ]]
    transmission = packet+ ("0"*)~
]=]

: parse ( str -- seq )
    [ digit> "%04b" sprintf ] map-concat (parse) ;

: part-1 ( seq -- n ) [ version>> ] map-sum ;

DEFER: evaluate
: slurp-packet ( length ns seq -- length' ns' seq' )
    unclip dup type>> 4 =
    [ get[ content length ] ] [ prefix evaluate ] if
    [ pick push ] [ '[ _ + ] 2dip ] bi* ;

: slurp-packets ( seq packet -- seq' length ns )
    [ 0 V{ } clone ] 2dip get[ length content ] [
        [ slurp-packet ] times
        [ 18 + ] 2dip
    ] [
        '[ pick _ = ] [ slurp-packet ] until
        [ 22 + ] 2dip
    ] if -rot ;

: binary ( seq quot -- n ) [ first2 ] dip call 1 0 ? ; inline

: evaluate ( seq -- seq' n length )
    unclip [ slurp-packets ] keep type>> {
        { 0 [ sum ] }
        { 1 [ product ] }
        { 2 [ infimum ] }
        { 3 [ supremum ] }
        { 5 [ [ > ] binary ] }
        { 6 [ [ < ] binary ] }
        { 7 [ [ = ] binary ] }
    } case swap ;

: part-2 ( seq -- n ) evaluate drop nip ;
