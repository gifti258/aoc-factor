using: sequences sorting splitting ;
in: 2022.01

! Calorie Counting
! part 1: most calories an elf is carrying
! part 2: sum of calories of the 3 most carrying elves

: parse ( seq -- quot ) { f } split [ sum ] map ;

: part-1 ( seq -- n ) supremum ;

: part-2 ( seq -- n ) natural-sort 3 tail* sum ;
