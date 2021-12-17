function main(r)
    nSteps = 1
    while !ismarker(r)
        for side in (Nord, Ost)
            i = 0
            while i != nSteps
                if ismarker(r)
                    break
                end
                move!(r, side)
                i += 1
                
            end
        end

        nSteps += 1
        for side in (Sud, West)
            i = 0
            while i != nSteps
                if ismarker(r)
                    break
                end
                move!(r, side)
                i += 1
                
            end
        end

        nSteps += 1
    end
end

main(r)