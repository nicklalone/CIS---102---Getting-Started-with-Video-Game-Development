pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- where does the ball begin?
ball_x = 3
x_speed = 3
ball_y = 15
y_speed = 3
ball_size = 3
col = 0


pad_x = 52
pad_y = 120
--paddle speed
pad_speed = 0
--paddle size
pad_w = 24
pad_h = 3
pad_c = 7

function _init()
cls()
end

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
	then x_speed = -3
	sfx(0) 
	end

	if ball_x < 1 
	then x_speed = 3 
	sfx(0)
	end

	if ball_y > 127 
	then y_speed = -3 
	sfx(0)
	end

	if ball_y < 1 
	then y_speed = 3
	sfx(0)
	end
end

function _draw()
	--background - ball - paddle
	rectfill(0,0,127,127,1)
	circfill(ball_x,ball_y,ball_size,3)
	rectfill(pad_x, pad_y,pad_x+pad_w,pad_y+pad_h,pad_c)
end

