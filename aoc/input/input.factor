using: accessors aoc.input.syntax aoc.math.parser assocs
io.encodings.utf8 io.files kernel math.parser namespaces
sequences splitting vocabs ;
in: aoc.input

: csn-line ( str -- seq ) "," split [ dec> ] map ;

: tsn-line ( str -- seq ) "\t" split [ dec> ] map ;

: tabular-line ( str -- seq ) split-words harvest [ dec> ] map ;

: #-vector ( str -- seq ) [ char: # = 1 0 ? ] { } map-as ;

input: input-lines ( -- seq ) ;
input: input-line ( -- str ) first ;
input: input-n ( -- n ) first dec> ;
input: input-ns ( -- seq ) [ dec> ] map ;
input: input-paragraphs ( -- seq ) { "" } split ;
input: input-2paragraphs ( -- before after ) { "" } split1 ;
input: input-csv-line ( -- seq ) first "," split ;
input: input-csn-line ( -- seq ) first csn-line ;
input: input-csn-lines ( -- seq ) [ csn-line ] map ;
input: input-tsn-line ( -- seq ) first tsn-line ;
input: input-tsn-lines ( -- seq ) [ tsn-line ] map ;
input: input-word-lines ( -- seq ) [ split-words ] map ;
input: input-tabular-line ( -- seq ) first tabular-line ;
input: input-tabular-lines ( -- seq ) [ tabular-line ] map ;
input: input-digit-line ( -- seq ) first dec>digits ;
input: input-digit-lines ( -- seq ) [ dec>digits ] map ;
input: input-matrix ( -- seq ) [ #-vector ] map ;

macro*: input-parse ( -- quot )
    current-path '[
        _ utf8 file-lines
        _ dictionary get at words>> "parse" of
        '[ _ execute( x -- x ) ] map
    ] ;
