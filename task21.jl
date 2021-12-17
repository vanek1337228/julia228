include("roblib.jl")
function countSegments(r::Robot)
    ans = 0
    moveWhileCan(r, (West, Sud))
    # Ура мы теперь в нижнем левом углу
    dir = Ost
    ans += processRow(r, dir, Nord)
    while !isborder(r, Nord)
        move!(r, Nord)
        dir = inverse(dir)
        ans += processRow(r, dir, Nord)
    end
    moveWhileCan(r, (West, Nord))
    # Ура мы теперь слева сверху

    dir = Sud
    ans += processRow(r, dir, Ost)

    while !isborder(r, Ost)
        move!(r, Ost)
        dir = inverse(dir)
        ans += processRow(r, dir, Ost)
    end

    return ans - 2
end

function processRow(r::Robot, side, toCheckSide)
    cnt = 0
    flag = false # Посчитали ли мы уже текущую перегородку со стороны
                 # toCheckSide
    while !isborder(r, side) || bypass(r, side)
        if isborder(r, toCheckSide)
            if !flag
                flag = true
                cnt += 1
            end
        else
            flag = false
        end
        if !isborder(r, side)
            move!(r, side)
        end
    end
    return cnt
end