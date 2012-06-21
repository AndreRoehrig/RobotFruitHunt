distance = (x1,x2) ->
    dist = x1-x2
    dist = Math.pow(dist,2)
    Math.sqrt(dist)

dividehelp = (x) ->
    if get_opponent_item_count(1) > get_total_item_count(1)/2 and x==1 then x = 0
    if get_opponent_item_count(2) > get_total_item_count(2)/2 and x==2 then x = 0
    if get_opponent_item_count(3) > get_total_item_count(3)/2 and x==3 then x = 0
    if get_opponent_item_count(4) > get_total_item_count(4)/2 and x==4 then x = 0
    if get_opponent_item_count(5) > get_total_item_count(5)/2 and x==5 then x = 0
   
    if x == 1 then x = 1
    
    if x == 2 and get_my_item_count(2) > get_total_item_count(2)/2 then x = 0
    if x == 3 and get_my_item_count(3) > get_total_item_count(3)/2 then x = 0
    if x == 4 and get_my_item_count(4) > get_total_item_count(4)/2 then x = 0
    if x == 5 and get_my_item_count(5) > get_total_item_count(5)/2 then x = 0
    
    else if x == 2 then x = 1 / ((get_total_item_count(2)/2 + 0.5) - get_my_item_count(2))
    else if x == 3 then x = 1 / ((get_total_item_count(3)/2 + 0.5) - get_my_item_count(3))
    else if x == 4 then x = 1 / ((get_total_item_count(4)/2 + 0.5) - get_my_item_count(4))
    else if x == 5 then x = 1 / ((get_total_item_count(5)/2 + 0.5) - get_my_item_count(5))
  

    x

arraydivider = (x) ->
    dividehelp(integer) for integer in x

matrixdivider = (x) ->
    arraydivider(array) for array in x

arraymax = (x) ->
    Math.max x...


matrixmax = (x) ->
    Math.max (arraymax(array) for array in x)...

arraysearch = (max,x) ->
    i = 0
    while i < x.length
        if max == x[i] then return i
        else i += 1
    return -1

matrixsearch = (max,x) ->
    i = 0
    while i < x.length
        if arraysearch(max,x[i]) >= 0 then return [i,arraysearch(max,x[i])]
        else i += 1
    return -1

distancearray = (x_pos,x,y,fac) ->
    i = 0
    while i < x.length
        x[i] = x[i] / Math.pow(fac,((distance(x_pos,i)+1 + y + 1)))
        i += 1
    return x



distancematrix = (x_pos,y_pos,x,fac) ->
    i = 0
    while i < x.length
        distancearray(x_pos,x[i],distance(i,y_pos),fac)
        i += 1
    x

nearermatrix = (matrix,my_x,my_y,his_x,his_y,fac) ->
    i = 0
    while i < matrix.length
        j = 0
        while j < matrix[i].length
            if (distance(my_x,i) + distance(my_y,j)) > (distance(his_x,i) + distance(his_y,j)) then matrix[i][j] = matrix[i][j] / Math.pow(fac,((distance(my_x,i) + distance(my_y,j))) - ((distance(his_x,i) + distance(his_y,j))))
            j += 1
        i += 1
    matrix
    


###########################################################################

new_game = ->



make_move = ->
    
    mul = 10000000000000000000000000000
    board = get_board()
    boardsize = board.length * board[0].length
    my_x = get_my_x()
    my_y = get_my_y()
    his_x = get_opponent_x()
    his_y = get_opponent_y()
    scoreboard = matrixdivider(board)
    mapp = distancematrix(my_y,my_x,scoreboard,1.175)
    finalmap = nearermatrix(mapp,my_x,my_y,his_x,his_y,2)
    highscore = matrixmax(finalmap)
    target_x = matrixsearch(highscore,finalmap)[0]
    target_y = matrixsearch(highscore,finalmap)[1]


    if my_x == target_x and my_y == target_y then return TAKE
    if my_x > target_x then return WEST
    if my_x < target_x then return EAST
    if my_y > target_y then return NORTH
    if my_y < target_y then return SOUTH

    PASS
