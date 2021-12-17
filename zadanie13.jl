# Практика 13 - продолжение практики 11:
# дорабтка функции try_move(::CountRectbordersRobot, ::HorizonSide)  Практика 11

# ЗАДАЧА 23

# Подсчет числа всех прямоугольных и прямолинейных перегородок на поле.
# В практике 10 был спроектирован тип CountbordersRobot, который можно было использовать только для подсчета либо горизонтальных, 
# либо вертикальных прямолинейных перегородо, либо для подсчета только прямоугольных перегородок, при отсутствии прямолинейных.

# Теперь спроектируем новый конкретный тип CountRectbordersRobot, подобный  CountbordersRobot, но который позволит 
# (с помощью обобщенной функции snake!) подсчитывать число внутренних перегородок и в случае, когда среди них имеются как прямоугольные 
# так и прямолинейные (вертикальные и горизонтальные).

# Горизонтальные и прямоугольные перегородки предполагается подсчитывать, проходя под ними, а вертикальные - когда будем в них упираться,
# причем лишь только когда будем упираться первый раз

include("lib_for_practic_10.jl")

mutable struct CountRectbordersRobot
    robot::Robot
    count::Int
    state::Int # state = 0 - сверху перегродка, state = 1 - сверху нет перегородки
end

# Изначально робот должен находиться в юго-западном углу, или, во всяком случае, непосредственно над роботом не должно быть перегородки
CountRectbordersRobot(r::Robot) = CountRectbordersRobot(r, 0, 0) 

"""

"""
function try_move!(robot::CountRectbordersRobot, side::HorizonSide)::Bool   
    if side == Nord # Перемещение вверх допустимо только при достижении конца горизонтального ряда
        @assert isborder(robot.robot, Ost) || isborder(robot.robot, West)
        return try_move!(robot.robot, Nord) # вызывается try_move!(::Any, ::HorizonSide)
    else
        @assert side in (Ost, West) 
        n = movements!(() -> !isborder(robot.robot, side), robot.robot, Sud)
        if isborder(robot.robot, side)  # робот достиг внешней рамки (на зпаде или на востоке)
            robot.state = 0 # 
            movements!(robot.robot, Nord, n) # робот переместился  в исходное положение
            return false
        end
        move!(robot.robot, side)
        if n == 0 # робот бепрепятственно переместился в заданном горизонтальном направлении 
            if robot.state == 1
                if !isborder(robot.robot, Nord)
                    robot.count += 1 # пройден конец очередной горизонтальной перегродки
#println(putmarker!(robot.robot)) # - для отладки   
                    robot.state = 0
                end
            else
                if isborder(robot.robot, Nord)
                    robot.state = 1
                end
            end        
        else # n > 0 - робот осуществляет обход перегородки, на которую наткнулся при горизонтальном перемещении
            m = movements!(() -> !isborder(robot.robot, Nord), robot.robot, side)
            movements!(robot.robot, Nord, n)
            if n==1 && m==0 # - робот ВПЕРВЫЕ наткнулся на очередную вертикальную прямолинейную перегородку
                robot.count += 1
#println(putmarker!(robot.robot)) # - для отладки                   
            end
        end
        return true 
    end  
end

get_num_borders(robot::CountRectbordersRobot) = robot.count

#--------------------------------------------------------------
# Целесообразно определить ещё следующую обобщенную функцию

"""
snake!(robot, (next_row_side, move_side)::NTuple{2,HorizonSide} = (Nord, Ost))

-- перемещает робота "змейкой" пока не будут пройденны все ряды в направлении next_row_side
"""
function snake!(robot, (next_row_side, move_side)::NTuple{2,HorizonSide}=(Nord, Ost)) # - это обобщенная функция
    # Робот - в (inverse(next_row_side), inverse(move_side)) - углу поля
    snake!(() -> false, robot, (next_row_side, move_side))
end

#--------------------------------------------------------------
#--------------------------------------------------------------
# Тест 1:

r = Robot(animate=true, "task23.sit") 
#УТВ: На ограниченном прямоугольной рамкой имеются прямолинейные или прямоугольные внутренние перегородки
#     Робот - в юго-западном углу

count_rectborders_robot = CountRectbordersRobot(r)
snake!(count_rectborders_robot)
get_num_borders(count_rectborders_robot) |> println # - это то же самое, что и println(get_num_borders(count_rectborders_robot))
#УТВ: напечатано число всех внутренних перегородок
