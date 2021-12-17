using HorizonSideRobots


function mark_perimeter(r::Robot)
    count1 = counter(r, 0)
    count2 = counter(r, 1)
    putmarker!(r)
    for side in 2:5
        move_forward!(r, side%4)
    end
    return_to_start!(r, count2, count1)
end

function move_forward!(r::Robot, side)
    while !isborder(r,HorizonSide(side))
        move!(r, HorizonSide(side))
        putmarker!(r)
    end
end

function return_to_start!(r::Robot, count2::Int,count1::Int)
    for i in 1:count2
        move!(r, HorizonSide(3))
    end
    for j in 1:count1
        move!(r, HorizonSide(2))
    end
end

function counter(r::Robot, side)
    count = 0
    while !isborder(r, HorizonSide(side))
        move!(r, HorizonSide(side))
        count+=1        
    end
    return count
end



mark_perimeter(r)