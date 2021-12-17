using HorizonSideRobots

function mark_innerrectangle_perimetr!(r::Robot)
    num_steps=fill(0,3) # - вектор-столбец из 3-х нулей
    for (i,side) in enumerate((Nord,Ost,Nord))
        num_steps[i]=moves!(r,side)
    end
    # Робот - в Юго-западном углу внешней рамки

    side = find_border!(r,Ost,side)
    # Робот - у западной границы внутренней перегородки

    mark_innerrectangle_perimetr!(r,side)
    # Робот - снова у западной границы внутренней прямоугольной перегородки

    moves!(r,Sud)
    moves!(r,West)
    # Робот - в Юго-западном улу внешней рамки

    for (i,side) in enumerate((Sud,West,Sud))
        moves!(r,side, num_steps[i])
    end
    # Робот - в исходном положении
end
function mark_innerrectangle_perimetr!(r::Robot, side::HorizonSide)
    direction_of_movement, direction_to_border = get_directions(side)
    for i ∈ 1:4   
        putmarkers!(r, direction_of_movement[i], direction_to_border[i]) 
    end
end
get_directions(side::HorizonSide) = 
    if side == Nord  
    # - обход будет по часовой стрелке      
        return (Nord,Ost,Sud, West), (Ost,Sud,West,Nord)
    else # - обход будет против часовой стрелки
        return (Sud,Ost,Nord,West), (Ost,Nord,West,Sud) 
    end