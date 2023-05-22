USING: grouping kernel math sequences sequences.extras sets ;
IN: 2015.05

! Doesn't He Have Intern-Elves For This?
! Count nice strings

: part-1 ( seq -- n )
    [
        [ [ "aeiou" in? ] count 3 >= ] [
            2 clump
            [ [ first2 = ] any? ]
            [ [ { "ab" "cd" "pq" "xy" } in? ] none? ] bi and
        ] bi and
    ] count ;

: part-2 ( seq -- n )
    [
        [
            dup 2 clump members [ count-subseq ] with map
            [ 1 > ] any?
        ] [ 3 clump [ first3 nip = ] any? ] bi and
    ] count ;
