include("roblib.jl")

function one_side_pyramid(r::Robot)
    coordinates = []
    cornerwalk(r, coordinates)
    building!(r)
    go_back!(r, coordinates)
end

function building!(r::Robot)
    i = 0;
    while isborder(r, Ost) == false
        move!(r, Ost)
        i = i + 1;
        putmarker!(r)
    end
    moves!(r, West)
    while i > 0 && isborder(r, Nord) == false
        i = i - 1
        move!(r, Nord)
        number_move_put!(r, Ost, i)
        moves!(r, West)
    end
        if isborder(r, Nord) == true
            putmarker!(r)
            putmarkers!(r, Sud)
        end
    putmarker!(r)
    putmarkers!(r, Sud)
end

"""
number_move_put! - функция из roblib, которая рисует маркеры на заданное кол-во шагов в различном направлении
"""




    
    
    





    
