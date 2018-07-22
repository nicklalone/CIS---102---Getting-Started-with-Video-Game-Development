ball_x = 3
x_speed = 1
ball_y = 15
y_speed = 1
ball_round = 3
col = 0

function _init()
cls()
end

function _update()
ball_y = ball_y+y_speed
ball_x = ball_x+x_speed
col=col+1

if ball_x > 127 
then x_speed = -10 
end

if ball_x < 0 
then x_speed = 10 
end

if ball_y > 127 
then y_speed = -10 
end

if ball_y < 0 
then y_speed = 10
end
end

function _draw()
cls()
circfill(ball_x,ball_y,ball_round,col)
end
