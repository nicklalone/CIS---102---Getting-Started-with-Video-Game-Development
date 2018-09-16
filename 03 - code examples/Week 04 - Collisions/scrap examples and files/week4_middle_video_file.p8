pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- where does the ball begin?
ball_x = 3
x_speed = 3
ball_y = 15
y_speed = 3
ball_size = 3
ball_r = 0.5
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
	local buttpress = false
	--always resets to false each frame
 local nextx,nexty
 --this is setting up a way to move the ball at an angle given a collision. 
 
 if btn(0) then
 --left(can do += instead)
 pad_speed -=5
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
 --this is for ball speed
 pad_x+=pad_speed
 -- this is moving the pad around.

 nextx=ball_x+x_speed
 nexty=ball_y+y_speed
 -- this is where the ball shifts given hitting the box.

 if nextx > 124 or nextx < 3 then
  nextx=mid(0,nextx,127)  
  x_speed = -x_speed
 end
-- what the above is doing is checking if nextx is greater than or less than the sides of the board. it then picks the middle
-- number between 0 and 127 with the nextx value.

 if nexty < 10 then
  nexty=mid(0,nexty,127)
  y_speed = -y_speed
 end
	-- same as above.

  -- check if ball hit pad
 if ball_box(nextx,nexty,pad_x,pad_y,pad_w,pad_h) then
  -- deal with collision
  if deflx_ball_box(ball_x,ball_y,x_speed,y_speed,pad_x,pad_y,pad_w,pad_h) then
   x_speed = -x_speed
  else
   y_speed = -y_speed
  end
  sfx(1)
  points+=1
 end
 
 ball_x=nextx
 ball_y=nexty

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

function ball_box(bx,by,box_x,box_y,box_w,box_h)
 -- checks for a collion of the ball with a rectangle
 if by-ball_r > box_y+box_h then return false end
 if by+ball_r < box_y then return false end
 if bx-ball_r > box_x+box_w then return false end
 if bx+ball_r < box_x then return false end
 return true
end

function deflx_ballbox(bx,by,bdx,bdy,tx,ty,tw,th)
 -- calculate wether to deflect the ball
 -- horizontally or vertically when it hits a box
 if bdx == 0 then
  -- moving vertically
  return false
 elseif bdy == 0 then
  -- moving horizontally
  return true
 else
  -- moving diagonally
  -- calculate slope
  local slp = bdy / bdx
  local cx, cy
  -- check variants
  if slp > 0 and bdx > 0 then
   -- moving down right
   debug1="q1"
   cx = tx-bx
   cy = ty-by
   if cx<=0 then
    return false
   elseif cy/cx < slp then
    return true
   else
    return false
   end
  elseif slp < 0 and bdx > 0 then
   debug1="q2"
   -- moving up right
   cx = tx-bx
   cy = ty+th-by
   if cx<=0 then
    return false
   elseif cy/cx < slp then
    return false
   else
    return true
   end
  elseif slp > 0 and bdx < 0 then
   debug1="q3"
   -- moving left up
   cx = tx+tw-bx
   cy = ty+th-by
   if cx>=0 then
    return false
   elseif cy/cx > slp then
    return false
   else
    return true
   end
  else
   -- moving left down
   debug1="q4"
   cx = tx+tw-bx
   cy = ty-by
   if cx>=0 then
    return false
   elseif cy/cx < slp then
    return false
   else
    return true
   end
  end
 end
 return false
end