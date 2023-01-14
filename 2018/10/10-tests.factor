using: 2018.10 aoc.input literals multiline sequences tools.test
;

${ [[
******  ******   ****   *****    ****    ****    ****      ***
     *       *  *    *  *    *  *    *  *    *  *    *      * 
     *       *  *       *    *  *       *       *           * 
    *       *   *       *    *  *       *       *           * 
   *       *    *       *****   *       *       *           * 
  *       *     *       *    *  *  ***  *  ***  *           * 
 *       *      *       *    *  *    *  *    *  *           * 
*       *       *       *    *  *    *  *    *  *       *   * 
*       *       *    *  *    *  *   **  *   **  *    *  *   * 
******  ******   ****   *****    *** *   *** *   ****    ***  ]]
rest } [ input-parse part-1 ] unit-test
{ 10886 } [ input-parse part-2 ] unit-test
