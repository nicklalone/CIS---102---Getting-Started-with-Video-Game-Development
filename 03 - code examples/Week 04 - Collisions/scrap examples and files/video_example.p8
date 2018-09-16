ball_x = 22
x_speed = 2
ball_y = 21
y_speed = 2

ball_radius = 1
ball_diameter = 2

pad_x = 52
pad_y = 120
--paddle speed
pad_speed = 0
--paddle size
pad_w = 24
pad_h = 3
pad_c = 7

function _update()
	buttpress = false
	--always resets to false each frame
	if btn(0) then
	--left(can do += instead)
	pad_speed =-5
	--pad_x = pad_x-5
	end
	if btn(1) then
	--right(can do += instead)
	pad_speed+=5
	--pad_x = pad_x+5
	end
	--if at the frame update 
	--a button isn't getting
	--pressed, slow down
	if not (buttpress) then
	pad_speed = pad_speed/1.7 
	end
	pad_x+=pad_speed
	
	--this is for ball speed
ball_y = ball_y+y_speed
ball_x = ball_x+x_speed

	--these are statements about ball movement.
	--can also make these 2 if into 1 with "or"
	if ball_x > 127 
	then x_speed = -2
	sfx(0) 
	end

	if ball_x < 1 
	then x_speed = 2 
	sfx(0)
	end

	if ball_y > 127 
	then y_speed = -2 
	sfx(0)
	end

	if ball_y < 1 
	then y_speed = 2
	sfx(0)
	end

	--turns the ball back to white after the function that turns it red.
	pad_c=7
	--if the ball has hit the paddle, then do something.
	if ball_hit(pad_x,pad_y,pad_w,pad_h) 
	then pad_c = 8
	
	end
end

function _draw()
	--background - ball - paddle
	rectfill(0,0,127,127,1)
	circfill(ball_x,ball_y,ball_diameter,3)
	rectfill(pad_x, pad_y,pad_x+pad_w,pad_y+pad_h,pad_c)
end

--function for dealing with the ball hitting the box. 
--this will return a value
--can be universal in its instantiation so we can use it in different ways.
function ball_hit(box_x,box_y,box_w,box_h)
	if ball_y - ball_radius > box_y + box_h 
	then return false
	end
	if ball_y + ball_radius < box_y 
	then return false
	end
	if ball_x - ball_radius > box_x + box_w
	then return false
	end
	if ball_x + ball_radius < box_x 
	then return false
	end
	return true
end