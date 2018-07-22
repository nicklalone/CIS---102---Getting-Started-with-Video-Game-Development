This is where we're starting. Let's walk through this so we can begin. 

```
px = 8
py = 8
pspd = 1 

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


But let's add a table. Remember back on collisions that you could use tables and a map to check against certain behaviors.

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

So here. We've set up some enemies to appear but they aren't doing anything yet.

We need to set up some other ways for enemies to run in to the map, maybe some barriers, and we need to run them into the player and have something happen. To do this, we can set up a bunch of checks against positions. 

```
pico-8 cartridge // http://www.pico-8.com
version 14
__lua__
px = 8 -- all sprites are 8 pixels in width.
py = 8
pspd = 1 

enemies = {} -- thjs is a table. this one represents this entire group of enemies of which there are 2.
enemies[1] = {} -- this is the table for enemy 1
enemies[1].x = 70 -- where does this enemy begin? pixel 70, 90
enemies[1].y = 90
enemies[2] = {} -- this is the table for enemy 2
enemies[2].x = 34
enemies[2].y = 110

tilez = {} -- this is setting the bounding boxes for various sprites.
tilez[1] = {} -- Note: These sprites won't be influenced by the Bump Function.
tilez[1].x = 40 -- This means that we need to write a similar function but for the tilez.
tilez[1].y = 48
tilez[2] = {}
tilez[2].x = 48
tilez[2].y = 48
tilez[3] = {}
tilez[3].x = 40
tilez[3].y = 56
tilez[4] = {}
tilez[4].x = 56
tilez[4].y = 48
tilez[5] = {}
tilez[5].x = 64
tilez[5].y = 48
tilez[6] = {}
tilez[6].x = 32
tilez[6].y = 48
tilez[7] = {}
tilez[7].x = 24
tilez[7].y = 48

function bump(x,y)
 return fget(mget(flr(x/8),flr(y/8)),0) -- fget gets the value of a sprite (flr) grabs the integer of a float. 
end -- mget gets the sprite number assigned to a cell on the map so as the sprite moves around, you can check for collisions.

function enc0llide(x1,y1,x2,y2) -- detect when the boxes collide with each other. Think inversely.
 return (x2 > x1+8 or x2 + 8 < x1 or y2 > y1+8 or y2+8 > y1) == false -- are all my borders apart or not touching.
     -- These two are for left and right. These two are checking the top and bottom.
end -- if any of these are true, then the whole thing cannot be false. This means things are colliding.

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
 for i in all(tilez) do -- this is creating a bunch of boxes for the 3rd sprite. a tetris shape
  spr(2,i.x,i.y)
 end 
 for i in all(enemies) do -- what this is doing is creating a variable called i that is used for that table enemies 
  spr(6,i.x,i.y) -- so it draws the sprite at the "enemies" table which in turn draws this sprite at each enemy.
 end -- think of it as a table on a table. the above dictates that everything in the table has this sprite assigned to it.
end -- and then with each individual enemy we can do something specific with it.
```