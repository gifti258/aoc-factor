USING: 2021.13 literals multiline sequences tools.test ;

{ 704 } [ input part-1 ] unit-test
${ [[
*  *  **   **    ** ***  **** *  *  ** 
*  * *  * *  *    * *  * *    *  * *  *
**** *    *  *    * ***  ***  **** *   
*  * * ** ****    * *  * *    *  * *   
*  * *  * *  * *  * *  * *    *  * *  *
*  *  *** *  *  **  ***  **** *  *  ** ]]
rest } [ input part-2 ] unit-test
