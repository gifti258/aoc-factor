USING: accessors assocs combinators heaps kernel math
math.parser multiline peg.ebnf sequences sequences.extras
slots.syntax ;
IN: 2015.22

! Wizard Simulator 20XX
! Turn-based RPG simulation
! part 1: least amount of mana to still win the fight
! part 2: … on hard difficulty

TUPLE: state
    b-hp damage
    pl-hp mana spent armor
    shield poison recharge ;

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    line = ([A-Za-z: ]+)~ n
]=]

: parse* ( seq -- state ) first2 50 500 0 0 0 0 0 state boa ;

: apply-effects ( state -- state )
    dup shield>>
    0 > [ [ 1 - ] change-shield 7 >>armor ] [ 0 >>armor ] if
    dup poison>>
    0 > [ [ 1 - ] change-poison [ 3 - ] change-b-hp ] when
    dup recharge>>
    0 > [ [ 1 - ] change-recharge [ 101 + ] change-mana ] when ;

: cast-spell-lose? ( state n -- state ? )
    2dup [ [ mana>> ] dip >= ] [ {
        { 113 [ shield>> zero? ] }
        { 173 [ poison>> zero? ] }
        { 229 [ recharge>> zero? ] }
        [ 2drop t ]
    } case ] 2bi and [ [ [
        [ [ - ] curry change-mana ]
        [ [ + ] curry change-spent ] bi
    ] keep {
        { 53 [ [ 4 - ] change-b-hp ] }
        { 73 [ [ 2 - ] change-b-hp [ 2 + ] change-pl-hp ] }
        { 113 [ 6 >>shield ] }
        { 173 [ 6 >>poison ] }
        { 229 [ 5 >>recharge ] }
    } case ] [ drop ] if ] keep not ;

: win? ( state -- state ? ) dup b-hp>> 0 <= ;

: lose? ( state -- state ? ) dup pl-hp>> 0 <= ;

: lose-1-hp-lose? ( state -- state ? )
    [ 1 - ] change-pl-hp lose? ;

: attack-lose? ( state -- state ? )
    dup get[ damage armor ] - '[ _ - ] change-pl-hp lose? ;

: turn ( state -- seq )
    apply-effects win? [
        { 53 73 113 173 229 } [ [ clone ] dip {
            { [ cast-spell-lose? ] [ drop f ] }
            { [ win? ] [ ] }
            { [ apply-effects win? ] [ ] }
            { [ attack-lose? ] [ drop f ] }
            [ ]
        } cond ] with map-sift
    ] unless ;

: turn* ( state -- seq )
    lose-1-hp-lose? [ drop f ] [ turn ] if ;

: least-mana ( state quot -- n )
    [ <min-heap> swap dup spent>>
    pick heap-push [ dup heap-peek drop win? nip ] ] dip '[
        dup heap-pop drop @
        [ [ spent>> ] keep ] map>alist over heap-push-all
    ] until heap-pop nip ; inline

: part-1 ( state -- n ) [ turn ] least-mana ;

: part-2 ( state -- n ) [ turn* ] least-mana ;
