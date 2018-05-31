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

-- We detect the edges of the board and if it hits them, the ball speed is sent backward -10 pixels or positive 10 pixels.
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

-- as the cartridge begins, clear the screen and draw a circle with the given variables as numeric input for the parameters.
function _draw()
cls()
circfill(ball_x,ball_y,ball_round,col)
end
```


