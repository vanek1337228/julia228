function do_n_steps!(r::Robot, side::HorizonSide, steps::Int)
    for i in 1:steps
        move!(r, side)
        if ismarker(r)
            return true
        end
    end
    if ismarker(r)
        return true
    end
    return false
end

function find_marker!(r::Robot) #Функция, ищущая маркер на безграничном поле
    if ismarker(r)
        return true
    end
    steps = 0
    now_step = 1
    side = Nord
    while !do_n_steps!(r, side, now_step)
        side = HorizonSide((Int(side) + 1) % 4)
        steps += 1
        if steps % 2 == 0
            now_step += 1
        end
    end
end

find_marker!(r)
#задача схожая с предыдущей