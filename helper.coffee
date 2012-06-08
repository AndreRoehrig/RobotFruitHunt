arraydivider = (x) ->
    1 / integer for integer in x

matrixdivider = (x) ->
    arraydivider(array) for array in x

arraymax = (x) ->
    Math.max x...

matrixmax = (x) ->
    Math.max (arraymax(array) for array in x)...

arraysearch = (max,x) ->
    i = 0
    while i <= x.length
        if max == x[i] then return i
        else i += 1
    return -1

