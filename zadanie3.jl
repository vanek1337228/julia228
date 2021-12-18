function main_3(r::Robot)
    mvs = []
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)
    line(r)
    corner(r)
    moves_back!(r, Nord, num_vert)
    moves_back!(r, Ost, num_hor)
end
function corner(r::Robot)
    while !isborder(r, Sud)
        move!(r,Sud)
    end
    while !isborder(r, West)
        move!(r,West)
    end
end
function moves_back!(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end
function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end
function line(r::Robot)
    while !ismarker(r)
        while !isborder(r, Ost)
            putmarker!(r)
            move!(r, Ost)
        end
        putmarker!(r)
        while !isborder(r, West)
            move!(r, West)
        end
        if !isborder(r, Nord)
            move!(r, Nord)
        else 
            break
        end
    end 
end  