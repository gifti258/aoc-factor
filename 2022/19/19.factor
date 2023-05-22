USING: accessors assocs assocs.extras combinators kernel math
math.functions math.matrices math.order math.parser math.vectors
multiline peg.ebnf sequences sequences.extras ;
IN: 2022.19

! Not Enough Minerals
! part 1: sum of product of highest possible number of opened
! geodes after 24 minutes and blueprint number
! part 2: product of the first three highest possible numbers of
! opened geodes after 32 minutes

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    line = "Blueprint "~ n ": Each ore robot costs "~ n
        " ore. Each clay robot costs "~ n
        " ore. Each obsidian robot costs "~ n " ore and "~ n
        " clay. Each geode robot costs "~ n " ore and "~ n
        " obsidian."~
]=]

TUPLE: state blueprint minutes robots resources ;

: <state> ( blueprint minutes -- state )
    { 1 0 0 0 } { 0 0 0 0 } state boa ;

CONSTANT: robots {
    { { 0 1 0 0 0 0 0 } { 1 0 0 0 } }
    { { 0 0 1 0 0 0 0 } { 0 1 0 0 } }
    { { 0 0 0 1 1 0 0 } { 0 0 1 0 } }
}

CONSTANT: always-build {
    { { 0 0 0 0 0 0 0 } { 0 0 0 0 } }
    { { 0 0 0 0 0 1 1 } { 0 0 0 1 } }
}

CONSTANT: resources {
    { 0 0 0 0 }
    { 1 0 0 0 }
    { 1 0 0 0 }
    { 1 0 0 0 }
    { 0 1 0 0 }
    { 1 0 0 0 }
    { 0 0 1 0 }
}

MEMO: max-cost ( state -- v )
    blueprint>> resources [ n*v ] 2map
    flip [ supremum ] map ; inline

: can-be-used? ( recipe state -- ? )
    swap [ {
        [ max-cost ]
        [ robots>> ]
        [ minutes>> '[ _ v*n ] bi@ ]
        [ resources>> ]
    } cleave ] [
        second '[ _ vdot ] tri@ + >
    ] bi* ; inline

:: can-be-built? ( recipe state -- m ? )
    recipe first2 :> ( blueprint-mask robot-mask )
    state
    [ blueprint>> blueprint-mask v* resources vdotm ]
    [ resources>> blueprint-mask resources vdotm v* v- ]
    [ robots>> ] tri
    zip [ 0 = ] reject-keys
    dup [ 0 = ] assoc-any-value?
    robot-mask [ 0 = ] all? not and ; inline

:: minutes-needed ( m recipe state -- minutes/f )
    recipe first2 :> ( blueprint-mask robot-mask )
    robot-mask [ 0 = ] all? [
        state minutes>>
    ] [
        m unzip v/ ?supremum
        [ ceiling >integer 1 + ]
        [ 1 ] if*
    ] if 1 max [ state minutes>> <= ] keep and ; inline

:: apply-changes ( minutes recipe state -- state' )
    recipe first2 :> ( blueprint-mask robot-mask )
    state clone
    [ minutes - ] change-minutes
    dup [ robots>> minutes v*n ] [
        blueprint>> blueprint-mask v*
        resources vdotm
    ] bi v- '[ _ v+ ] change-resources
    [ robot-mask v+ ] change-robots ; inline

: collapse-state ( state -- state' )
    dup {
        [ max-cost ]
        [ robots>> v- ]
        [ minutes>> v*n ]
        [ robots>> v+ ]
        [
            resources>>
            [ [ min ] 2map 3 head ]
            [ last suffix ] bi
        ]
    } cleave >>resources ; inline

MEMO:: max-geodes ( state -- n )
    state minutes>> 0 > [
        robots [ state can-be-used? ] filter
        always-build append [ :> recipe
            recipe state can-be-built? [ drop f ] [
                recipe state minutes-needed dup [
                    recipe state apply-changes
                    collapse-state
                    max-geodes
                ] when
            ] if
        ] map-sift ?supremum
    ] [ state resources>> last ] if ;

: part-1 ( seq -- n )
    [ [ 24 <state> max-geodes ] [ first ] bi * ] map-sum ;

: part-2 ( seq -- n )
    3 head [ 32 <state> max-geodes ] map-product ;
