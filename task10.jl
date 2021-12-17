tempSum = 0
numOfCells = 0

function countAvgTemp(r::Robot)
    dir = Ost
    move_while_can!(r, dir)
    dir = inverse(dir)
    while !isborder(r,Nord)
      move!(r, Nord)
      move_while_can!(r, dir)
      dir = inverse(dir)
    end
    if numOfCells > 0 
        return tempSum/numOfCells
    else
        return 0
    end   
end

#Двигает робота в сторону side, пока нет перегородки
function move_while_can!(r::Robot, side)
    checkCell(r)
    while !isborder(r, side)
        move!(r, side)
        checkCell(r) 
    end
end

function checkCell(r::Robot)
   global tempSum, numOfCells
   if ismarker(r) 
      tempSum += temperature(r) 
      numOfCells += 1
   end
end

function inverse(side)
    return HorizonSide(mod(Int(side) + 2, 4))
end


