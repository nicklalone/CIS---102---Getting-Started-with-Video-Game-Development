pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

-- create the bricks.
-- the {} indicates a table. 
function buildbricks()
 local i
 brick_x={}
 -- table for x values of bricks.
 brick_y={}
 -- table for y values of bricks.
 brick_v={}
 -- table for visibility of bricks.
 for i=1,60 do
 -- for every value between 1 and 66 do something.
  add(brick_x,4+((i-1)%10)*(brick_w+2))
 -- add bricks.
  add(brick_y,20+flr((i-1)/10)*(brick_h+2))
  -- add bricks 20 pixels apart.
  add(brick_v,true)
  -- create a variable for visibility of bricks.
 end
end

function show_menu()
 cls()
 spr(0,0,0,20,20)
 print('press ❎ to begin', 20, 70,10)
  if btn(5) then
  go_game = true
  -- then we initiate the building of bricks.
  buildbricks()
  -- the game begins.
  run_game()
  life = 3
  end
end 

function game_over()
 cls()
 print('game over!!!')
 print('press z to restart.')
 ball_x = 50
 x_speed = 2
 ball_y = 100
 y_speed = 2
 ball_size = 3
 col = 0

 -- where does the pad begin?
 pad_x = 52
 pad_y = 120
 --paddle speed
 pad_speed = 0
 --paddle size
 pad_w = 24
 pad_h = 3
 pad_c = 7
  if btn(4) then
  cls()
  sfx(3)
  g0_game = false
  game_done = false
  life = 3
  end
-- what happens when life == 0
end

function keep_going()
 cls()
 print('you lost a life! try harder!!!')
 print('press x to continue!!')
-- what happens if life > 0
 ball_x = 50
 x_speed = 2
 ball_y = 100
 y_speed = 2
 ball_size = 3
 col = 0

 -- where does the pad begin?
 pad_x = 52
 pad_y = 120
 --paddle speed
 pad_speed = 0
 --paddle size
 pad_w = 24
 pad_h = 3
 pad_c = 7
 if btn(5) then
 cls()
 go_game = true
 game_done = false
 end
end

-- we start the game here.
function _init()
-- first, we clear the screen
cls()
-- where does the ball begin?
ball_x = 50
x_speed = 2
ball_y = 100
y_speed = 2
ball_size = 3
col = 0

-- where does the pad begin?
pad_x = 52
pad_y = 120
--paddle speed
pad_speed = 0
--paddle size
pad_w = 24
pad_h = 3
pad_c = 7

-- brick size
brick_w=10
brick_h=4
-- set the various states of the game. we want to begin with both as false. 
go_game = false
game_done = false
-- function ends.
end

function _update()
if go_game == false and game_done == false then show_menu() end
if go_game == true and game_done == false then run_game() end 
if go_game == false and game_done == true and life > 0 then keep_going() end
if life == 0 then game_over() end
end

function run_game()
	buttpress = false
	--always resets to false each frame
	if btn(0) then
	buttpress = true
	--left(can do += instead)
	pad_speed=- 5
	--pad_x = pad_x-5
	end
	if btn(1) then
	buttpress = true
	--right(can do += instead)
	pad_speed=5
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
	then
	sfx(1)
	game_done = true
 go_game = false
 life = life - 1 
	end

	if ball_y < 1 
	then y_speed = 2
	sfx(0)
	end

pad_c = 7

if ball_hit(pad_x,pad_y,pad_w,pad_h)
then pad_c = 8
y = 'its a hit!!!!!!!!!!'
y_speed = -abs(y_speed)
end

for i=1,#brick_x do
  -- check if ball hit brick
  if brick_v[i] and ball_hit(brick_x[i],brick_y[i],brick_w,brick_h) then
  -- if the above statements are true then.
  brick_v[i] = false
  -- make the visibility of the brick false.
  y = 'its a hit!!!!!!!!!!'
  y_speed = -y_speed
  sfx(2)
  -- reverse the y speed.
  end
end

end

function _draw()
 if go_game == true and game_done == false then
	cls()
 print('lives remaining = ',0,0,2)
 print(life,70,0,13)
	circfill(ball_x,ball_y,ball_size,3)
	rectfill(pad_x, pad_y,pad_x+pad_w,pad_y+pad_h,pad_c)

-- this is drawing the bricks
 for i=1,#brick_x do
  if brick_v[i] then
   rectfill(brick_x[i],brick_y[i],brick_x[i]+brick_w,brick_y[i]+brick_h,14)
  end
 end
 end
end

function ball_hit(box_x,box_y,box_w,box_h)

if ball_y - ball_size > box_y + box_h
then
x = 'y-r > box_y + box_h'
return false
end

if ball_y + ball_size < box_y
then
x = 'y+r < box_y'
return false
end

if ball_x - ball_size > box_x + box_w
then
x = 'x-r > box_x+box_w'
return false
end

if ball_x + ball_size < box_x
then
x = 'x+r < box_x'
return false
end

return true
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000ccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000cccccccccccccc000000000000000000
000000ccccccccc00000000000000000000000000000000000000000000000000000000000ccccc00000ccccc0000000cccccccccccccc000000000000000000
000000ccccccccc00000000000000000000000000000000000000000000000000000000000ccccc0000cccccc0000000cccccccccccccc000000000000000000
000000cccccccccccc0000000000000000000000000000000000000000000cccccc0000000ccccc000ccccccc0000000cccccccccccccc000000000000000000
000000cccccccccccc0000000000000000000000000000000000000000ccccccccc0000000ccccc000ccccccc0000000cccccccccccccc000000000000000000
000000ccccc00ccccc0000000000000000000ccccc000000000000000cccccccccc0000000ccccc00cccccccc0000000ccccc000000000000000000000000000
000000ccccc00ccccc000000ccccccccc0000ccccc00000000000000ccccccccccc0000000ccccc0ccccccccc0000000cccccc00000000000000000000000000
000000ccccc00cccccccc0ccccccccccccc00ccccc0000000000000cccccccccccc0000000ccccccccccccc000000000ccccccc0000000000000000000000000
000000ccccc00000ccccc0ccccccccccccc00ccccc0000000000000ccccccccccc00000000ccccccccccccc000000000cccccccc000000000000000000000000
000000ccccc00000ccccc0ccccccccccccc00ccccc0000000000000cccccccc00000000000cccccccccccc0000000000ccccccccc00000000000000000000000
000000ccccc00000ccccc0cccccccccccccc0cccccc000000000000cccccc0000000000000ccccccccccccc0000000000cccccccccc000000000000000000000
000000cccccccccccccccccccccccccccccc0cccccc000000000000cccccc0000000000000ccccccccccccc00000000000cccccccccc00000000000000000000
000000cccccccccc00000cccccc000cccccc0cccccc000000000000ccccc00000000000000ccccccccccccc00000000000ccccccccccc0000000000000000000
000000cccccccccc00000cccccc000cccccc0cccccc000000000000ccccc00000000000000ccccccccccccc0000000000000cccccccccc000000000000000000
000000cccccccccc00000cccccc0000ccccc0cccccc000000000000ccccc00000000000000cccccccccccccc0000000000000ccccccccc000000000000000000
000000cccccccccccccc0cccccc0000ccccc00ccccc000000000000ccccc00000000000000ccccccc0ccccccc00000000000000cccccccc00000000000000000
000000ccccc0000ccccc0ccccc000000000000ccccc000000000000cccccc0000000000000cccccc00cccccccc00000000000000ccccccc00000000000000000
000000ccccc0000ccccc0ccccc000000000000ccccc000000000000cccccc00000000000000ccccc00cccccccc000000000000000cccccc00000000000000000
000000ccccc0000ccccc0ccccc000000000000cccccc00000000000ccccccc0000000000000ccccc000cccccccc00000000000000cccccc00000000000000000
000000ccccc0000ccccc0cccccc00000000000ccccccc0000000000cccccccc000000000000ccccc0000cccccccc000000000000ccccccc00000000000000000
000000cccccccccccc000cccccc00000000000cccccccc00ccccc000cccccccc00000000000ccccc0000cccccccccc000000000cccccccc00000000000000000
000000cccccccccccc000cccccc00000000000ccccccccccccccc000ccccccccccccccc0000ccccc00000ccccccccc0000000cccccccccc00000000000000000
000000cccccccccccc000cccccc00000000000ccccccccccccccc0000cccccccccccccc0000ccccc00000ccccccccc0000000cccccccccc00000000000000000
000000cccccccccccc000cccccc000000000000cccccccccccccc0000cccccccccccccc0000ccccc000000cccccccc0000000ccccccccc000000000000000000
000000cccccccccccc0000ccccc0000000000000ccccccccccccc00000ccccccccccccc0000ccccc0000000ccccccc0000000cccccccc0000000000000000000
0000000000000000000000ccccc00000000000000ccccccccccc0000000cccccccccccc0000ccccc000000000000000000000ccccccc00000000000000000000
0000000000000000000000ccccc00000000000000000000000000000000000ccccccc000000ccccc000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000cccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000cccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000cccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000ccccccccccccccccc0000000000000000000000
000000cccccccccccc00000000000000000000ccccccccccccccc000000000000000000000000000000000ccccccccccccccccccccc000000000000000000000
000000cccccccccccccccc000000000000cccccccccccccccccccccc0000000000000000000000000000ccccccccccccccccccccccc000000000000000000000
0000000ccccccccccccccccccc000000cccccccccccccccccccccccccc000000000000000000000000cccccccccccccccccccccccccc00000000000000000000
000000000cccccccccccccccccccccccccccccccccccccccccccccccccc0000000000000000000000ccccccccccccccccccccccccccc00000000000000000000
000000000000cccccccccccccccccccccccccccccccccccccccccccccccc00000000000000000000cccccccccccccc0000000cccccccc0000000000000000000
00000000000000cccccccccccccccccccccccccccc0000000cccccccccccccc000000000000000cccccccccccc000000000000ccccccc0000000000000000000
000000000000000000ccccccccccccccccccccc0000000000000ccccccccccccc00000000000cccccccccccc000000000000000cccccc0000000000000000000
0000000000000000000000cccccccccccccc00000000000000000cccccccccccccccccccccccccccccccccc0000000000000000cccccc0000000000000000000
00000000000000000000000000000cccccc00000000000000000000cccccccccccccccccccccccccccccc00000009999900000ccccccc0000000000000000000
00000000000000000000000000000ccccccc00000000000000000000cccccccccccccccccccccccccccc000000009999900000ccccccc0000000000000000000
00000000000000000000000000000cccccccc0000000000999990000000ccccccccccccccccccccccc00000000009999900000cccccc00000000000000000000
000000000000000000000000000000ccccccccc00000000999990000000cccccccccccccccccccccccc0000000009999900000cccccc00000000000000000000
000000000000000000000000000000ccccccccccc00000099999000000cccccccc00000000ccccccccccc00000009999900000cccccc00000000000000000000
0000000000000000000000000000000cccccccccccc00009999900000ccccccccc00000000cccccccccccccccccc999990000cccccc000000000000000000000
00000000000000000000000000000000ccccccccccccc0099999000ccccccccccc000000000ccccccccccccccccc99999cccccccccc000000000000000000000
000000000000000000000000000000000cccccccccccccc9999900ccccccccccc000000000000ccccccccccccccc99999cccccccccc000000000000000000000
00000000000000000000000000000000000cccccccccccc99999cccccccccccc000000000000000ccccccccccccc99999cccccccccc000000000000000000000
0000000000000000000000000000000000000cccccccccccccccccccccccccc000000000000000000ccccccccccccccccccccccccc0000000000000000000000
000000000000000000000000000000000000000cccccccccccccccccccccc000000000000000000000000000cccccccccccccccccc0000000000000000000000
00000000000000000000000000000000000000000ccccccccccccccccccc00000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000cccccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100002f050220501a050120500d05008050040500205002030020100200002000020000200002000020000200002000020000200002000020000200002000020000100007800397003a7003c7003e7003e700
00030000271601f1501a1501514012140101400c13009130071300513003120011501710014100131001210011100101000e1000d1000d1000c1000b1000a1000c100091000a1000710005100051000310003100
00010000224501d4501b45016450134500f4500c4500a450084500645004450024500145000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500002e7502b75029750277502575023750217501f7501d7501a750187501575013750117500f7500e7500d7500b7500a750097500875006750057500475002750017500c7000a70008700067000470002700
