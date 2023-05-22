USING: 2022.10 aoc.input literals multiline sequences tools.test
;

{ 14240 } [ input-parse part-1 ] unit-test
${ [[
###  #    #  # #    #  # ###  #### #  # 
#  # #    #  # #    # #  #  #    # #  # 
#  # #    #  # #    ##   ###    #  #### 
###  #    #  # #    # #  #  #  #   #  # 
#    #    #  # #    # #  #  # #    #  # 
#    ####  ##  #### #  # ###  #### #  # ]]
rest } [ input-parse part-2 ] unit-test
