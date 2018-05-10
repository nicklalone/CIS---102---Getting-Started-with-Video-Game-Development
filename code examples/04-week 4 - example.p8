--ball position
ball_x = 1
ball_y = 33
--ball speed
ball_dx = 2
ball_dy = 2
--ball size
ball_r = 2
ball_dr = 0.5

--paddle starting position
pad_x = 52
pad_y = 120
--paddle speed
pad_dx = 0
--paddle size
pad_w = 24
pad_h = 3

--what to do upon running
function _init()
cls()
end

--updating stuff is the heart of the game
--per frame updates
function _update()
	buttpress = false
	--always resets to false each frame
	if btn(0) then
	--left(can do += instead)
	pad_dx =-5
	--pad_x = pad_x-5
	end
	if btn(1) then
	--right(can do += instead)
	pad_dx+=5
	--pad_x = pad_x+5
	end
	--if at the frame update 
	--a button isn't getting
	--pressed, slow down
	if not (buttpress) then
	pad_dx = pad_dx/1.7 
	end
	pad_x+=pad_dx
	
	--this is for ball speed
ball_y = ball_y+ball_dy
ball_x = ball_x+ball_dx

--these are statements about ball movement.
--can also make these 2 if into 1 with "or"
if ball_x > 127 
then ball_dx = -1
sfx(0) 
end

if ball_x < 1 
then ball_dx = 1 
sfx(0)
end

if ball_y > 127 
then ball_dy = -1 
sfx(0)
end

if ball_y < 1 
then ball_dy = 1
sfx(0)
end
end

function _draw()
--background - ball - paddle
rectfill(0,0,127,127,1)
circfill(ball_x,ball_y,ball_r,3)
rectfill(pad_x, pad_y,pad_x+pad_w,pad_y+pad_h,7)
end
