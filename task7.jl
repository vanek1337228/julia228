parity = true

# Главная функция
function chessPainter(r::Robot)
    move_while_can(r,West, f)
    move_while_can(r,Sud, f)
    paintCell!(r)
    dir = Ost
    move_while_can(r,dir,paintCell!)
    dir = inverse(dir)
    while !isborder(r,Nord)
        move!(r,Nord)
        paintCell!(r)
        move_while_can(r,dir,paintCell!)
        dir = inverse(dir)
    end    
    
end

function f(r::Robot)
    global parity
    parity = !parity
end

function paintCell!(r::Robot)
    global parity 
    parity = !parity
    if parity 
        putmarker!(r)
    end    
end

function move_while_can(r::Robot, side, callback)
    while !isborder(r,side)
        move!(r, side)
        callback(r)
    end
end

function inverse(side)
    return HorizonSide(mod(Int(side) + 2, 4))
end
