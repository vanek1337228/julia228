using HorizonSideRobots

"""
    moves!(r::Robot, side::HorizonSide)

-- Перемещает робота до упора в заданном направлении
"""
function moves!(r::Robot, side::HorizonSide)
    while isborder(r, side) == false
        move!(r, side)
    end
end

"""
    moves!(r::Robot, side::HorizonSide, num_steps::Int)

-- Перемещает робота в направлении side на заданное число шагов
"""
function moves!(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end

"""
    putmarkers!(r::Robot, side::HorizonSide)

-- Ставит маркеры всюду в заданном направлении, пока робот не встретит перегородку,
   исключая начальную позицию
"""
putmarkers!(r::Robot, side::HorizonSide) =
    while isborder(r, side) == false
        move!(r, side)
        putmarker!(r)
    end

function move_by_markers(r::Robot, side::HorizonSide)
    while ismarker(r) == true
        move!(r, side)
    end
end


"""
    inverse(side::HorizonSide)

-- Возвращает направление, противоположное заданному
"""
inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))


"""
    inverse(side::HorizonSide)

-- Возвращает направление, следующее против часовой стрелки заданному
"""
nextCounterClockwise(side::HorizonSide) = HorizonSide(mod(Int(side) + 1, 4))

"""
    moveWhileCan(sides)

    -- Двигает робота пока можно двигаться хотя бы в одном
    -- из заданных направлений
"""
function moveWhileCan(r::Robot, sides)
    moved = true
    while moved
        moved = false
        for side in sides
            if !isborder(r, side)
                move!(r, side)
                moved = true
            end
        end
    end
end

function bypass(r::Robot, dir)
    bypassDir = nextCounterClockwise(dir)
    antiBypassDir = inverse(bypassDir)
    numSteps = 0
    while !isborder(r, bypassDir) && isborder(r, dir)
        move!(r, bypassDir)
        numSteps += 1
    end
    if isborder(r, dir) && isborder(r,bypassDir)
        moves!(r, antiBypassDir, numSteps)
        return false
    end
    move!(r, dir)
    moves!(r, antiBypassDir, numSteps)
    return true
end