USING: accessors aoc.input.syntax assocs io.encodings.utf8
io.files kernel math.parser namespaces sequences splitting
vocabs ;
IN: aoc.input

: csn-line ( str -- seq ) "," split [ dec> ] map ;

: tsn-line ( str -- seq ) "\t" split [ dec> ] map ;

: tabular-line ( str -- seq ) split-words harvest [ dec> ] map ;

: digit-line ( str -- seq ) [ digit> ] { } map-as ;

: #-vector ( str -- seq ) [ CHAR: # = 1 0 ? ] { } map-as ;

INPUT: input-lines ( -- seq ) ;
INPUT: input-line ( -- str ) first ;
INPUT: input-n ( -- n ) first dec> ;
INPUT: input-ns ( -- seq ) [ dec> ] map ;
INPUT: input-paragraphs ( -- seq ) { "" } split ;
INPUT: input-2paragraphs ( -- before after ) { "" } split1 ;
INPUT: input-csv-line ( -- seq ) first "," split ;
INPUT: input-csn-line ( -- seq ) first csn-line ;
INPUT: input-csn-lines ( -- seq ) [ csn-line ] map ;
INPUT: input-tsn-line ( -- seq ) first tsn-line ;
INPUT: input-tsn-lines ( -- seq ) [ tsn-line ] map ;
INPUT: input-word-lines ( -- seq ) [ split-words ] map ;
INPUT: input-tabular-line ( -- seq ) first tabular-line ;
INPUT: input-tabular-lines ( -- seq ) [ tabular-line ] map ;
INPUT: input-digit-line ( -- seq ) first digit-line ;
INPUT: input-digit-lines ( -- seq ) [ digit-line ] map ;
INPUT: input-matrix ( -- seq ) [ #-vector ] map ;

MACRO*: input-parse ( -- quot )
    current-path '[
        _ utf8 file-lines
        _ dictionary get at words>> "parse" of
        '[ _ execute( x -- x ) ] map
    ] ;
