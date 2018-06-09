**By the end of this week you should be able to:**
1. Know what buttons are used by players in PICO-8
1. Know how to assign those buttons to IF statements for PICO-8
1. Understand how to use the _\_update_ function in conjunction with player input
1. Create functions that will manipulate variables depending on player input.
1. Consider other uses for player input.

**Optionally, you could also learn to:**
1. Create a title screen
1. Use the sound effects editor
1. Understand game states

**Table of Contents**
1. [Last Week](#last-week)
1. [Getting Started with Input](#getting-started-with-input)
1. [Smoothing Movement](#smoothing-movement)
1. [Friction](#friction)

# Week 3 - Making Stuff Move When Players Want It To.
3 items form the basis of this week's lesson. THey all surround the idea of allowing users to actually interact with your system.
1. More uses for IF Statements.
1. Using the pre-defined buttons to allow users to interact with your program.
1. Friction and uses for the _update function.

From last week, we did something with a ball. It looked a little like this: 
```
-- Where does the ball begin?
ball_x = 3
x_speed = 1
ball_y = 15
y_speed = 1
ball_round = 3
col = 0

-- What to do when the program begins?
function _init()
cls()
end

-- What to do during each frame? Note that this one is currently set to 30.
function _update()
ball_y = ball_y+y_speed
ball_x = ball_x+x_speed
col=col+1

-- We detect the edges of the board and if it hits them, 
-- the ball speed is sent backward -10 pixels or positive 10 pixels.
-- depending on the side of the board it hits.
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

-- as the cartridge begins, clear the screen and draw a circle 
-- with the given variables as numeric input for the parameters.
function _draw()
cls()
circfill(ball_x,ball_y,ball_round,col)
end
```

To add to this code, let's walk through each aspect of the cart in order to consider how to add some depth and feel.

```
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
```

