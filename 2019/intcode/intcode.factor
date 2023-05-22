USING: accessors aoc.input.syntax combinators deques dlists
kernel math math.parser math.text.utils sequences slots.syntax
splitting ;
IN: 2019.intcode

TUPLE: intcode-state
    memory { ip initial: 0 }
    opcode modes { base initial: 0 }
    inputs outputs ;

: prepare ( str -- seq ) "," split [ dec> ] V{ } map-as ;

INPUT: input-prepare ( -- seq ) first prepare ;

: mode ( state offset -- mode ) 1 - swap modes>> ?nth 0 or ;

: address ( state offset -- address )
    dupd [ over ip>> + swap memory>> ?nth 0 or ] [ mode ] 2bi
    2 = [ [ base>> ] [ + ] bi* ] [ nip ] if ;

: value ( state offset -- value state )
    dupd [ address ] [ mode ] 2bi
    even? [ over memory>> ?nth 0 or ] when swap ;

: put ( value state offset -- state )
    [ address ] keepd [ memory>> set-nth ] keep ;

: args ( state n -- state ) [ + ] curry change-ip ;

: single-step ( state -- state )
    dup get[ ip memory ] nth
    100 /mod [ 1 digit-groups >>modes ] dip [ >>opcode ] keep {
        { 1 [ 1 value 2 value [ + ] dip 3 put 4 args ] }
        { 2 [ 1 value 2 value [ * ] dip 3 put 4 args ] }
        { 3 [ [ inputs>> pop-back ] keep 1 put 2 args ] }
        { 4 [ 1 value [ outputs>> push-front ] keep 2 args ] }
        { 5 [ 1 value swap zero? [ 3 args ] [ 2 value swap >>ip ] if ] }
        { 6 [ 1 value swap zero? [ 2 value swap >>ip ] [ 3 args ] if ] }
        { 7 [ 1 value 2 value [ < 1 0 ? ] dip 3 put 4 args ] }
        { 8 [ 1 value 2 value [ = 1 0 ? ] dip 3 put 4 args ] }
        { 9 [ 1 value [ + ] with change-base 2 args ] }
        { 99 [ 1 args ] }
    } case ;

: run ( state -- state )
    [ dup opcode>> 99 = ] [ single-step ] until ;

: input/output ( seq input -- output )
    1dlist <dlist> [ intcode-state new ] 3dip
    set[ memory inputs outputs ]
    run outputs>> peek-front ;

: run-until-output ( state -- state )
    [ dup opcode>> { 4 99 } member? ] [ single-step ] do until ;
