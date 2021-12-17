include("roblib.jl")

function all_painted_marks!(r::Robot)
    coordinates = []
    cornerwalk(r, coordinates)
    paint!(r)
    go_back!(r, coordinates)
end

function paint!(r::Robot)
    putmarker!(r)
    putmarkers!(r, Ost)
    while isborder(r, Nord) == false
        if isborder(r, Ost) == true
            move!(r, Nord)
            putmarker!(r)
            putmarkers!(r, West)
        end
        if isborder(r, West) == true
            move!(r, Nord)
            putmarker!(r)
            putmarkers!(r, Ost)
        end
    end
    if isborder(r, Nord) == true
        if isborder(r, West) == true
            while isborder(r, Sud) == false
                move!(r, Sud)
            end
        end
        if isborder(r, Ost) == true
            while isborder(r, Sud) == false
                move!(r, Sud)
            end
            while isborder(r, West) == false
                move!(r, West)
            end
        end
    end
end
    
