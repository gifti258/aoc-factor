USING: arrays kernel math math.parser math.vectors ranges
sequences sequences.extras sequences.repeating ;
IN: 2019.16

! Flawed Frequency Transmission
!

: nth-digit ( str n -- n )
    { 0 1 0 -1 } [ <array> ] with map-concat over length 1
    + cycle rest [ string>digits { } like ] dip v* sum abs 10
    mod ;

: fft ( str -- str )
    dup length [1..b] [ nth-digit >digit ] with "" map-as ;

: part-1 ( str -- str ) 100 [ fft ] times 8 head ;
