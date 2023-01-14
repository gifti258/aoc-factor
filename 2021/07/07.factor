using: kernel math ranges sequences ;
in: 2021.07

! The Treachery of Whales
! Least amount of fuel to align crabs

: fuel ( seq quot -- n )
    [ dup supremum [0..b] ] dip
    '[ swap [ - abs @ ] with map-sum ] with map infimum ; inline

: part-1 ( seq -- n ) [ ] fuel ;

: part-2 ( seq -- n ) [ [1..b] sum ] fuel ;
