using: ascii grouping kernel math sequences sets ;
in: 2022.03

! Rucksack Reorganization
! Sum priority of common compartment items/badges

: priority ( str -- n )
    first [ LETTER? 26 0 ? ] [ ch>lower 96 - ] bi + ;

: part-1 ( seq -- n ) [ halves intersect priority ] map-sum ;

: part-2 ( seq -- n )
    3 group [ intersect-all priority ] map-sum ;
