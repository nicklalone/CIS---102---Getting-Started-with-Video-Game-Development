This week, i'll introduce you to a different sort of tutorial for PICO-8. This one is from Alan Jamieson from St. Mary's College of Maryland. It is a great tutorial and it also introduces a number of new patterns and sequences that some of you are already experimenting with inside of your final projects.

The video can be found here: https://www.youtube.com/watch?v=xAEoSuYVEmE

and below is the bulk of the code from the tutorial. I'll walk through chunks of it to explain a little about it. 

We'll start here: 

```lua
px = 8
py = 8
pspd = 1 
```

This is to establish 3 variables: `player starting position on the x-axis (px)`, `player starting position on the y-axis (py)`, and `the initial speed of the player (pspd)`. Let's check out the next few lines. 

```lua
function bump(x,y)

 local mx=flr(x/8)
 local my=flr(y/8)

 local tile = mget(mx,my)

 return fget(tile,0) 
end
```
There's a lot going on here! Let's see if we can take it apart. We'll go in order. 

* Note the two variables `local mx` and `local my`. Each of these are divided by 8 with the additional command of `flr()`. This is a clever bit of doing. It is divided by `8` so that the 8-pixel width sprite won't look like it's moved until 8-pixels later. This flr returns the `"floor"` of a particular variable (e.g. the `1` in `1.2` or the `9` in `9.7`. 0-0.9 remain as 0. 1-1.9 remain as 1. And so on. This allows us to calculate the relative position of a sprite for collision purposes. 

* `mget()` or "Map Get" searches a particular map and sends it to a particular coordinate on a map. This can be combined with `fget()` to indicate where and when things intersect.

* `fget()` is an API function that gets two arguments `(n,[f])` or "The Sprite Number" and "The flag index." Note if you examine each sprite that there are a number of dots you can click on. Each of these is a flag and with those, you can have them do specific things. The values for these are 0-7 and while we won't be using them in this class, it's a good time to introduce this possibility of development. 

* `return fget(tile,0)` is returning the evaluation of a particular sprite and tile. 

This is why the function is called `bump()`. This is necessary to do a number of things. First, notice that each pixel is divided by 8. This is because each sprite is 8 pixels wide.  

This next set of instructions are about the `_update()` function which you learned about in week 3 and have used in each of your games. Let's take a look at it. 

```lua
function _update() 
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
   px = 112 -- right of screen 
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
  if bump(px,py) or bump(px+7,py) then
   py -= pspd
  end
 end
end
```

So what's happening here? 
Well, this is checking to see if a particular button is pressed. If a button is pressed, then a certain number of things occur. First, when a button is pressed (directional in this case) the player's x-value (`px`) or y-value (`py`) will increase (`px += pspd`) or decrease (`px -= pspd`). 

So then what? Well, there is an `if` statement here. `if the player's x or y value is greater than or less than the side or top of the screen -16` then set the value of that axis to its maximum value. This is a cheap way to stop player movement over a particular sprite. Because the value is done with the `math-floor` or `flr` function, the value is precise. 

Each button has that value. And this is where we begin. To help, we'll call upon the `_draw()` function to put things in place. I'll place in-line comments to describe each line. 
```lua
function _draw()
 cls()
 map(0,0,0,0,128,128)
 spr(3,px,py) -- keep drawing sprite 3 in the position of the two variables px and py.
 for i in all(enemies) do -- what this is doing is creating a variable called i that is used for that table enemies 
  spr(6,i.x,i.y) -- so it draws the sprite at the "enemies" table which in turn draws this sprite at each enemy.
 end -- think of it as a table on a table. the above dictates that everything in the table has this sprite assigned to it.
end -- and then with each individual enemy we can do something specific with it.
```

So if this is from the collisions lesson, we can add to it. For example, we could add a couple of enemies. To do this, we are going to add a `table{}` to indicate a group of variables associated with a particular group of variables. 

```lua
enemies = {} -- thjs is a table. this one represents this entire group of enemies of which there are 2.
enemies[1] = {} -- this is the table for enemy 1
enemies[1].x = 70 -- where does this enemy begin? pixel 70, 90
enemies[1].y = 90
enemies[2] = {} -- this is the table for enemy 2
enemies[2].x = 34
enemies[2].y = 110
``` 
Place this code under the global variables (HINT: Global variables will be declared before anything else). This table allows us to do a number of things. Note here that there are 3 tables here. `enemies[1], enemies[2], and enemies`. This instantiates 3 tables: all enemies, enemy 1 and enemy 2. Note that each enemy has an `x` and `y` value. 

We then need to draw a few enemies. In the `_draw` function, we can place a `for` loop that draws sprites. 

```lua
for i in all(enemies) do
	spr(6,i.x,i.y)
```
What this allows you to do is draw sprite 7 at its table's x and y values. It does this for every single frame. But these are just sprites. They are not particularly useful as your player's sprite will just walk straight over this object. 

We need to set up some other ways for enemies to run in to the map, maybe some barriers, and we need to run them into the player and have something happen. To do this, we can set up a bunch of checks against positions. 

```lua
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
```

```lua
function enc0llide(x1,y1,x2,y2) -- detect when the boxes collide with each other. Think inversely.
 return (x2 > x1+8 or x2 + 8 < x1 or y2 > y1+8 or y2+8 > y1) == false
end
```

are all my borders apart or not touching. These two are for left and right. These two are checking the top and bottom. if any of these are true, then the whole thing cannot be false. This means things are colliding.

```lua
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
```


```lua
for i in all(tilez) do 
  spr(2,i.x,i.y)
end 
```

-- this is creating a bunch of boxes for the 3rd sprite. a tetris shape
 for i in all(enemies) do -- what this is doing is creating a variable called i that is used for that table enemies 
 
Now we need to set up and see what sorts of collisions are occuring with the player sprite. This will occur as the player pushes buttons.

```lua
gameover = false
```

```lua
function _update() -- the button (btn) functions are checking against the map which is created in bump(x,y)
 if btn(0) then
  px -= pspd
  if px < 8 then
   px = 8 -- left of screen
  end
  for i in all(tilez) do
   if enc0llide(px,py,i.x,i.y) then
    px += pspd
    break
   end
  end
 end

 if btn(1) then 
  px += pspd
  if px > 112 then
   px = 112 -- right of screen minus sprite size for wall - size of sprite. 128 - 8 (wall) - 8 (character)
  end -- so if the x value is 112, the x value can only be 112. this makes a collision occur.
  for i in all(tilez) do
   if enc0llide(px,py,i.x,i.y) then
    px -= pspd
    break
   end
  end 
 end

 if btn(2) then 
  py -= pspd
  if py < 8 then
   py = 8 -- top of screen
  end
  for i in all(tilez) do
   if enc0llide(px,py,i.x,i.y) then
    py += pspd
    break
   end
  end 
 end

 if btn(3) then 
  py += pspd
  if py > 112 then
   py = 112 --bottom of screen
  end
  for i in all(tilez) do
   if enc0llide(px,py,i.x,i.y) then
    py -= pspd
    break
   end
  end
 end

-- can add a check for death here. 

 for i in all(enemies) do
  if enc0llide(px,py,i.x,i.y) then
   gameover = true
  end
 end

end
```


```lua 
function _draw()
 cls()
 if gameover == false then
  map(0,0,0,0,128,128)
  spr(3,px,py) -- keep drawing sprite 3 in the position of the two variables px and py.
 
  for i in all(tilez) do -- this is creating a bunch of boxes for the 3rd sprite. a tetris shape
   spr(2,i.x,i.y)
  end 
 
  for i in all(enemies) do -- what this is doing is creating a variable called i that is used for that table enemies 
   spr(6,i.x,i.y) -- so it draws the sprite at the "enemies" table which in turn draws this sprite at each enemy.
  end -- think of it as a table on a table. the above dictates that everything in the table has this sprite assigned to it.
 
 else 
  print('game over!', 44, 64)
 end 
end -- and then with each individual enemy we can do something specific with it.
```

In the above, we're checking for a game over screen. 

Now we're set to add some AI!

```lua
px = 8 -- all sprites are 8 pixels in width.
py = 8
pspd = 1 
gameover = false
pc = 0

enemies = {} -- thjs is a table. this one represents this entire group of enemies of which there are 2.
enemies[1] = {} -- this is the table for enemy 1
enemies[1].x = 70 -- where does this enemy begin? pixel 70, 90
enemies[1].y = 90
enemies[2] = {} -- this is the table for enemy 2
enemies[2].x = 34
enemies[2].y = 110

tilez = {} -- this is setting the bounding boxes for various sprites.
tilez[1] = {} -- note: these sprites won't be influenced by the bump function.
tilez[1].x = 40 -- this means that we need to write a similar function but for the tilez.
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

function enc0llide(x1,y1,x2,y2) -- detect when the boxes collide with each other. think inversely.
 return (x2 > x1+8 or x2+8 < x1 or y2 > y1+8 or y2+8 < y1) == false -- are all my borders apart or not touching.
end -- if any of these are true, then the whole thing cannot be false. this means things are colliding.

function distance(x1,y1) -- cartesian distance
 return abs(px - x1) + abs(py-y1) -- manhattan distance
end

function _update() -- the button (btn) functions are checking against the map which is created in bump(x,y)
 if btn(0) then
  px -= pspd
  if px < 8 then
   px = 8 -- left of screen
  end
  for i in all(tilez) do
   if enc0llide(px,py,i.x,i.y) then
    px += pspd
    break
   end
  end
 end

 if btn(1) then 
  px += pspd
  if px > 112 then
   px = 112 -- right of screen minus sprite size for wall - size of sprite. 128 - 8 (wall) - 8 (character)
  end -- so if the x value is 112, the x value can only be 112. this makes a collision occur.
  for i in all(tilez) do
   if enc0llide(px,py,i.x,i.y) then
    px -= pspd
    break
   end
  end 
 end

 if btn(2) then 
  py -= pspd
  if py < 8 then
   py = 8 -- top of screen
  end
  for i in all(tilez) do
   if enc0llide(px,py,i.x,i.y) then
    py += pspd
    break
   end
  end 
 end

 if btn(3) then 
  py += pspd
  if py > 112 then
   py = 112 --bottom of screen
  end
  for i in all(tilez) do
   if enc0llide(px,py,i.x,i.y) then
    py -= pspd
    break
   end
  end
 end

 if pc < 12 then -- moving stuff with the pc variable. it's just counting and running this.
  enemies[1].x +=1  -- this is just a moving guy. a goomba, etc.
  enemies[1].y -=2
 end

 if pc >= 12 then
  enemies[1].x -=1
  enemies[1].y +=2
 end

 pc = (pc + 1) % 24 -- this is the mod function. 

 if distance(enemies[2].x,enemies[2].y) < 70 then -- if the enemy is less than 30 pixels away, do something.
  if abs(px - enemies[2].x) > abs(py - enemies[2].y) then
   if (px - enemies[2].x < 0 ) then -- where is the player in respect to the enemy?
    enemies[2].x -=1
   else 
    enemies[2].x +=1
   end
  else 
   if (py - enemies[2].y < 0 ) then -- where is the player in respect to the enemy?
    enemies[2].y -=1
   else 
    enemies[2].y +=1
   end
  end
 end

-- can add a check for death here. 

 for i in all(enemies) do
  if enc0llide(px,py,i.x,i.y) then
   gameover = true
  end
 end

end


function _draw()
 cls()
 if gameover == false then
  map(0,0,0,0,128,128)
  spr(3,px,py) -- keep drawing sprite 3 in the position of the two variables px and py.
 
  for i in all(tilez) do -- this is creating a bunch of boxes for the 3rd sprite. a tetris shape
   spr(2,i.x,i.y)
  end 
 
  for i in all(enemies) do -- what this is doing is creating a variable called i that is used for that table enemies 
   spr(6,i.x,i.y) -- so it draws the sprite at the "enemies" table which in turn draws this sprite at each enemy.
  end -- think of it as a table on a table. the above dictates that everything in the table has this sprite assigned to it.
 
 else 
  print('game over!', 44, 64)
 end 
end -- and then with each individual enemy we can do something specific with it.
```


