USING: 2016.08 aoc.input literals multiline sequences splitting
tools.test ;
IN: 2016.08.tests

CONSTANT: example [[ rect 3x2
rotate column x=1 by 1
rotate row y=0 by 4
rotate column x=1 by 1]]

{ 6 } [ example string-lines [ parse ] map part-1 ] unit-test
{ 106 } [ input-parse part-1 ] unit-test
${ [[
 **  **** *    **** *     **  *   *****  **   *** 
*  * *    *    *    *    *  * *   **    *  * *    
*    ***  *    ***  *    *  *  * * ***  *    *    
*    *    *    *    *    *  *   *  *    *     **  
*  * *    *    *    *    *  *   *  *    *  *    * 
 **  *    **** **** ****  **    *  *     **  ***  ]]
rest } [ input-parse part-2 ] unit-test
