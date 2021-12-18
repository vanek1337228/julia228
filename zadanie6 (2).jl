using HorizonSideRobots

function mark_innerrectangle_perimetr!(r::Robot)
    num_steps=fill(0,3) #создаем вектор-столбец, состоящий из трех нулей
    for (i,side) in enumerate((Nord,Ost,Nord))
        num_steps[i]=moves!(r,side)
    end
    #робот в юго-западном верхнем углу

    side = find_border!(r,Ost,side)
    #робот у запаздной границы внешней перегородки

    mark_innerrectangle_perimetr!(r,side)
    # робот у западной границы внутренней прямоугольной перегородки

    moves!(r,Sud)
    moves!(r,West)
    #робот занимает юго-задпадный угол угол внешней рамки

    for (i,side) in enumerate((Sud,West,Sud))
        moves!(r,side, num_steps[i])
    end
    #возвращает робота в исходное положение
end
function mark_innerrectangle_perimetr!(r::Robot, side::HorizonSide)
    direction_of_movement, direction_to_border = get_directions(side)
    for i ∈ 1:4   
        putmarkers!(r, direction_of_movement[i], direction_to_border[i]) 
    end
end
get_directions(side::HorizonSide) = 
    if side == Nord  
    #обход будет по часовой стрелке      
        return (Nord,Ost,Sud, West), (Ost,Sud,West,Nord)
    else #обход будет против часовой стрелки
        return (Sud,Ost,Nord,West), (Ost,Nord,West,Sud) 
    end