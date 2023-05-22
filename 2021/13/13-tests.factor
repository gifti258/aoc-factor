USING: 2021.13 aoc.input literals multiline sequences tools.test
;

{ 704 } [ input-2paragraphs parse part-1 ] unit-test
${ [[
*  *  **   **    ** ***  **** *  *  ** 
*  * *  * *  *    * *  * *    *  * *  *
**** *    *  *    * ***  ***  **** *   
*  * * ** ****    * *  * *    *  * *   
*  * *  * *  * *  * *  * *    *  * *  *
*  *  *** *  *  **  ***  **** *  *  ** ]]
rest } [ input-2paragraphs parse part-2 ] unit-test
