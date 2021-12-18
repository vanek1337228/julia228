using HorizonSideRobots


function mark_x_cross(r::Robot)#основная функция для решения задачи
    for side1 in 0:3
        side2 = (side1+1)%4
        println(side2)
        move_forward!(r, side1, side2)
        return_to_start!(r, change_side(side1),change_side(side2))
    end
    putmarker!(r)
end

function move_twice!(r, side1, side2)#кусок кода, отвечающий за движение по диагонали(по двум координатам, вместо одной)
	move!(r, HorizonSide(side1))
	move!(r,  HorizonSide(side2))
end


function move_forward!(r, side1, side2)
    while !(isborder(r,HorizonSide(side1)) || isborder(r,HorizonSide(side2)))
        move_twice!(r, side1, side2)
        putmarker!(r)
    end
end

function return_to_start!(r, side1, side2)#возвращает робота в начало
    while ismarker(r)
        move_twice!(r, side1, side2)
    end
end

function change_side(side)#меняет сторону движения
    return mod(side+2, 4)
end

mark_x_cross(r)
