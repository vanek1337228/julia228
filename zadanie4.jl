function mark_ladder(r::Robot) #Главная функция для решения задачи
    go_ver = moves!(r, Sud)
    go_hor = moves!(r, Ost)

    while !isborder(r, Nord)
        putmarkers!(r, West)
        move_by_markers!(r, Ost)
        putmarker!(r)
        move!(r, Nord)
        move!(r, West)
    end

    putmarkers!(r, West)
    move_by_markers!(r, Ost)
    putmarker!(r)
    
    for side in (Ost, Sud)
        right_bottom(r, side)
    end

    moves!(r, Nord, go_ver)
    moves!(r, West, go_hor)

end

function moves!(r::Robot, side::HorizonSide) #переносит робота в правый нижний угол и считает шаги, пройденные за собой
    num_steps = 0
    while !isborder(r,side)
        move!(r,side)
        num_steps += 1
    end
    return num_steps
end

function moves!(r::Robot, side::HorizonSide, num_steps::Int) #возвращает робот по пройденным шагам
    for _ in 1:num_steps 
        move!(r,side)
    end
end

function putmarkers!(r::Robot, side::HorizonSide) #выстраивает дорожку из маркеров
    while !isborder(r,side)
        move!(r,side)
        putmarker!(r)
    end
end

function move_by_markers!(r::Robot, side::HorizonSide) #возвращается по маркерам
    while ismarker(r)
        move!(r,side)
    end
end

function right_bottom(r::Robot, side::HorizonSide) #возвращается в исходное положение(правый нижний угол)
    while !isborder(r, side)
        move!(r, side)
    end
end

mark_ladder(r)