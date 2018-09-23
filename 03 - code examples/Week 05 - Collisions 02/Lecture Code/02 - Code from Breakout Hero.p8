pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
 ball_x = 34
 x_speed = 2
 ball_y = 12
 y_speed = 2
 ball_r=2
 ball_dr=0.5
 
 pad_x=52
 pad_y=120
 pad_speed=0
 pad_w=24
 pad_h=3
 pad_c=7

function _init()
 cls()
end
 
function _update()
 local buttpress=false
 local nextx,nexty
 
 if btn(0) then
  --left
  pad_speed=-2.5
  buttpress=true
  --pad_x-=5
 end
 if btn(1) then
  --right
  pad_speed=2.5
  buttpress=true
  --pad_x+=5
 end
 if not(buttpress) then
 pad_speed=pad_speed/1.3
 end

 pad_x+=pad_speed
 
 nextx=ball_x+x_speed
 nexty=ball_y+y_speed
 
 if nextx > 124 or nextx < 3 then
  nextx=mid(0,nextx,127)  
  x_speed = -x_speed
 end
 if nexty < 10 or nexty > 124 then
  nexty=mid(0,nexty,127)
  y_speed = -y_speed
 end
 
 -- check if ball hit pad
 if ball_box(nextx,nexty,pad_x,pad_y,pad_w,pad_h) then
  -- deal with collision
  if deflx_ball_box(ball_x,ball_y,x_speed,y_speed,pad_x,pad_y,pad_w,pad_h) then
   x_speed = -x_speed
  else
   y_speed = -y_speed
  end
 end
 
 ball_x=nextx
 ball_y=nexty
 
end
 
 
function _draw()
 cls(1)
 circfill(ball_x,ball_y,ball_r, 10)
 rectfill(pad_x,pad_y,pad_x+pad_w,pad_y+pad_h,pad_c)
 rectfill(0,0,128,6,0) 
end
 
function ball_box(bx,by,box_x,box_y,box_w,box_h)
 -- checks for a collion of the ball with a rectangle
 if by-ball_r > box_y+box_h then return false end
 if by+ball_r < box_y then return false end
 if bx-ball_r > box_x+box_w then return false end
 if bx+ball_r < box_x then return false end
 if by + ball_r == 0.5 then return false end
 return true
end
 
function deflx_ball_box(bx,by,bdx,bdy,tx,ty,tw,th)
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
