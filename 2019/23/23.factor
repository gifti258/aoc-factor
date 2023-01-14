using: 2019.intcode accessors deques dlists grouping
kernel literals sequences slots.syntax ;
in: 2019.23

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

: loop-until-255 ( seq -- seq packet )
    f swap [
        [
            dup
            [ get[ ip memory ] nth 3 = ]
            [ inputs>> deque-empty? ] bi and
            [ dup inputs>> -1 swap push-front ] when
            dup opcode>> 99 = [
                [
                    single-step dup
                    [ get[ ip memory ] nth 3 = ]
                    [ opcode>> 99 = ] bi or not
                ] loop
            ] unless
        ] map v{ } clone over [
            outputs>> [ over push ] slurp-deque
        ] each 3 group [
            unclip dup 255 =
            [ drop nipd swap ]
            [ pick nth inputs>> push-all-front ] if
        ] each over not
    ] loop swap ;

: part-1 ( -- n )
    <network> loop-until-255 nip second ;
