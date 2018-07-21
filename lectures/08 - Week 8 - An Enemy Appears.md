```  
px = 8
py = 8
pspd = 1 

enemies = {} -- thjs is a table. this one represents this entire group of enemies of which there are 2.
enemies[1] = {} -- this is the table for enemy 1
enemies[1].x = 70 -- where does this enemy begin? pixel 70, 90
enemies[1].y = 90
enemies[2] = {} -- this is the table for enemy 2
enemies[2].x = 34
enemies[2].y = 110

function bump(x,y)
 return fget(mget(flr(x/8),flr(y/8)),0) -- fget gets the value of a sprite (flr) grabs the integer of a float. 
end -- mget gets the sprite number assigned to a cell on the map so as the sprite moves around, you can check for collisions.

function _update() -- the button (btn) functions are checking against the map which is created in bump(x,y)
 if btn(0) then
  px -= pspd
  if px < 8 then
   px = 8 -- left of screen
  end
  if bump(px-1, py) or bump(px,py+7) then
   px += pspd
  end
 end

 if btn(1) then 
  px += pspd
  if px > 112 then
   px = 112 -- right of screen minus sprite size for wall - size of sprite. 128 - 8 (wall) - 8 (character)
  end -- so if the x value is 112, the x value can only be 112. this makes a collision occur.
  if bump(px+7,py) or bump(px+7, py+7) then
   px -= pspd
  end
 end

 if btn(2) then 
  py -= pspd
  if py < 8 then
   py = 8 -- top of screen
  end
  if bump(px,py) or bump(px+7,py) then
   py += pspd
  end
 end

 if btn(3) then 
  py += pspd
  if py > 112 then
   py = 112 --bottom of screen
  end
  if bump(px,py+7) or bump(px+7,py+7) then
   py -= pspd
  end
 end
end


function _draw()
 cls()
 map(0,0,0,0,128,128)
 spr(3,px,py) -- keep drawing sprite 3 in the position of the two variables px and py.
 for i in all(enemies) do -- what this is doing is creating a variable called i that is used for that table enemies 
  spr(6,i.x,i.y) -- so it draws the sprite at the "enemies" table which in turn draws this sprite at each enemy.
 end -- think of it as a table on a table. the above dictates that everything in the table has this sprite assigned to it.
end -- and then with each individual enemy we can do something specific with it.
```
