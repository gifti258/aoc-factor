USING: continuations io kernel lint lint.vocabs
lint.vocabs.private math.parser ranges sequences
sequences.product tools.test tools.time vocabs.files
vocabs.hierarchy vocabs.metadata vocabs.refresh.monitor ;

IN: tools.test.private

:: (unit-test) ( output input -- error/f failed? tested? )
    [
        { } input [ benchmark time. ] curry with-datastack
        output assert-sequence= f f
    ] [ t ] recover t ;

IN: aoc.lint

: prefixes ( -- seq ) 2015 2022 [a..b] [ >dec ] map ;

: prefixes* ( -- seq )
    prefixes { { "aoc" } {
        "groups" "input" "input.syntax" "lint" "md5" "matrices"
    } } [ "." join ] product-map append ;

: load-all* ( -- ) prefixes [ load ] each ;

: lint-all ( -- ) prefixes [ lint-vocabs drop ] each ;

: unused-all ( -- )
    prefixes* [
        disk-child-vocab-names [ find-unused. flush ] each
    ] each ;

: unused-tests ( -- )
    prefixes [
        disk-child-vocab-names [
            vocab-tests [
                [ path>vocab-name ".tests" append ] keep
                find-unused-in-file dup empty?
                [ print-no-unused-vocabs ]
                [ print-unused-vocabs ] if flush
            ] each
        ] each
    ] each ;

: test-all* ( -- )
    prefixes [
        disk-child-vocab-names [ don't-test? ] reject [
            vocab-tests [ run-test-file ] each
        ] each
    ] each ;
