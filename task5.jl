include("roblib.jl")

function all_corners_mark(r::Robot)
    coordinates = []
    cornerwalk(r, coordinates)
    paint!(r)
    go_back!(r, coordinates)
end

function paint!(r::Robot)
    for side in (Nord, Ost, Sud, West)
        moves!(r, side)
        putmarker!(r)
    end
end
