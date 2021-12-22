function poisk_marker(r)
    steps = 0
    while !ismarker(r)
        for s in (Nord, West)
            for i in 0:steps
                if ismarker(r)
                break
            end
                move!(r,s)
            end
        end
        z=steps+=1
        for s in (Sud, Ost)
            for i in 0:z
                if ismarker(r)
                break
            end 
                move!(r,s)
            end
        end
        steps+=1
    end
end

poisk_marker(r)
