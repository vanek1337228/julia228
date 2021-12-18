function move_to_side(side, m) #достаточно несложная задача, вся суть которой понять, как реализовать поиск единственного прохода
    for i in 1:m
        move!(r, side)
    end
end

n = 1
while isborder(r, Nord)
    if (n % 2 == 0)
        move_to_side(West, n)
    else
        move_to_side(Ost, n)
    end
    global n += 1
end