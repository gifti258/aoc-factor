USING: 2019.intcode accessors continuations deques dlists
grouping kernel literals sequences sets slots.syntax ;
IN: 2019.23

! Category Six
! part 1: get first y send to address 255
! part 2: get first y send from NAT to address 0 twice in a row

: <network> ( -- seq )
    50 <iota> [
        intcode-state new
            $[ input-prepare ] clone >>memory
            swap 1dlist >>inputs
            <dlist> >>outputs
    ] map ;

: ?provide-input ( state -- state )
    dup [ get[ ip memory ] nth 3 = ]
    [ inputs>> deque-empty? ] bi and
    [ dup inputs>> -1 swap push-front ] when ;

: run-until-input ( state -- state )
    [ dup get[ ip memory ] nth { 3 99 } member? ]
    [ single-step ] do until ;

: network-round ( states -- states outputs )
    [ ?provide-input run-until-input ] map V{ } clone over
    [ outputs>> [ over push ] slurp-deque ] each ;

ERROR: found-y Y ;

: handle-nat ( states packet quot -- states )
    [ unclip dup 255 = ] dip
    [ pick nth inputs>> push-all-front ] if ; inline

: first-255-Y ( states -- states )
    network-round 3 group
    [ [ drop second found-y ] handle-nat ] each first-255-Y ;

: part-1 ( -- n ) [ <network> first-255-Y ] [ Y>> ] recover ;

: run-until-idle ( ys packet states -- ys packet states )
    [
        network-round [
            3 group [ [ drop nipd swap ] handle-nat ] each
            dup [ inputs>> deque-empty? ] all?
        ] keep empty? and not
    ] loop 2dup first inputs>> push-all-front [
        dup second pick 2dup in?
        [ drop found-y ] [ adjoin ] if
    ] dip run-until-idle ;

: part-2 ( -- n )
    [
        HS{ } clone f <network> [ run-until-input ] map
        run-until-idle 2drop
    ] [ Y>> ] recover ;
