USING: assocs assocs.extras grouping kernel math math.parser
multiline sequences ;
IN: 2021.24

! Arithmetic Logic Unit
! Find the largest/smallest possible model number

! The input consists of 18-line blocks of the same structure,
! but different values A and B. If A is positive, it pushes
! digit+B onto the base-26 stack stored in variable z. If A is
! negative, it pops digit0+B0 from the stack. For the stack to
! be empty and therefore z to be zero in the end, digit0+B0 has
! to be equal to digit1-A1. Both digits can now be minimized or
! maximized, depending on the part.

: parse ( word-lines -- n-pairs )
    18 group [ { 5 15 } nths-of [ third dec> ] map ] map ;

: (part) ( pairs neg-quot pos-quot -- n )
    [
        H{ } clone ! { index digit } assoc
        V{ } clone ! { index A B } stack
    ] 3dip '[ (( { A B } index ))
        prefix dup second neg? [
            first2 pick pop first3 nip (( i1 A1 i0 B0 ))
            swapd + (( i1 i0 n ))
            dup neg? _ _ if (( i1 i0 n1 n0 ))
            -rotd swap (( n1 i1 n0 i0 )) [ reach set-at ] 2bi@
        ] [ over push ] if
    ] each-index drop
    14 <iota> values-of 0 [ [ 10 * ] dip + ] reduce ; inline

: part-1 ( pairs -- n ) [ 9 + 9 ] [ 9 9 rot - ] (part) ;

: part-2 ( pairs -- n ) [ 1 1 rot - ] [ 1 + 1 ] (part) ;
