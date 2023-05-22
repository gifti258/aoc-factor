USING: grouping math math.combinatorics sequences
sequences.extras ;
IN: 2016.03

! Squares With Three Sides
! Find the number of possible triangles
! In a possible triangle every side is shorter than the sum of
! the other two.

: triangle? ( seq -- ? ) [ first3 + < ] all-permutations? ;

: part-1 ( seq -- n ) [ triangle? ] count ;

: part-2 ( seq -- n ) 3 group [ flip ] map-concat part-1 ;
