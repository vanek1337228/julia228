function solve(r::Robot)
    mvs = []
    go_to_corner!(r, mvs) #занимает угол
    mark_corners!(r) #закрашивает углы
    return_back!(r, mvs) #возвращает робота в исходное положение
end

function moveIfPossible!(r::Robot, mvs::AbstractArray, side::HorizonSide)
    if !isborder(r, side)
        move!(r, side)
        push!(mvs, side)
    end
end

function go_to_corner!(r::Robot, mvs::AbstractArray) #идет в углы
    while isborder(r, Nord) == false || isborder(r, Ost) == false
        moveIfPossible!(r, mvs, Nord)
        moveIfPossible!(r, mvs, Ost)
    end
    # робот достиг правого верхнего угла 
end

function moves!(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
    end 
end

function mark_corners!(r::Robot)
    for side in (Sud, West, Nord, Ost)
        moves!(r, side)
        putmarker!(r)
    end
end

function inverse(side::HorizonSide) #принимает сторону света и возращает противоположную
    return HorizonSide(mod(Int(side) +2, 4))
end 

function return_back!(r::Robot, mvs::AbstractArray)#возвращает робота в начало
    while length(mvs) > 0
        last_move = pop!(mvs)
        move!(r, inverse(last_move))
    end  
end

solve(r)