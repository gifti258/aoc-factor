USING: continuations io kernel lexer lint lint.vocabs
lint.vocabs.private math.parser namespaces ranges sequences
sequences.product tools.test tools.time vocabs vocabs.files
vocabs.hierarchy vocabs.metadata vocabs.refresh.monitor ;

IN: tools.test.private

:: (unit-test) ( output input -- error/f failed? tested? )
    [
        { } input [ benchmark time. ] curry with-datastack
        output assert-sequence= f f
    ] [ t ] recover t ;

IN: tools.test

SYNTAX: TEST:
    scan-token loaded-child-vocab-names test-vocabs ;

: skip-long-tests ( quot -- )
    f long-unit-tests-enabled? rot with-variable ; inline

IN: aoc.lint

: prefixes ( -- seq ) 2015 2022 [a..b] [ >dec ] map ;

: prefixes* ( -- seq )
    prefixes { { "aoc" } {
        "assign" "groups" "input" "input.syntax" "lint"
        "matrices" "md5"
    } } [ "." join ] product-map append ;

: load-all* ( -- ) prefixes [ load ] each ;

: lint-all* ( -- ) prefixes [ lint-vocabs drop ] each ;

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
