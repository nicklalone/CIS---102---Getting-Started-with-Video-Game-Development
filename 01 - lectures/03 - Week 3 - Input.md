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
1. [Movement](#first---we-figure-out-how-to-move-the-paddle-around.)
1. [Quickness](#second---next,-we-think-about-how-fast-we-want-the-paddle-to-be.)
1. [The Sides of the Board](#third---we-figure-out-what-to-do-about-the-sides-of-the-board.)
1. [Friction and Style](#finally---friction-and-style!)
1. [Putting it all together](#putting-it-all-together.)

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
## Getting started with Input
So, we have a ball. It bounces around in a predictible pattern and it changes color. THIS IS AWESOME! But...we need more. This is just a boring old ball looking thing and not much else. 

The next step relates to the player and their representation - The paddle. That tiny little rectangle that can bounce the ball around as needed. 

So how do we begin? 

Well, let's add a rectangle.  The rectangle we add also has to be defined globally so that we can dynamically manipulate it within the game loop. Let's begin with this rectangle. It contains the size, position, and speed.  

```
--paddle starting position
pad_x = 52
pad_y = 120
--paddle speed
pad_dx = 0
--paddle size
pad_w = 24
pad_h = 3
``` 
So now we have a ball, we have the beginnings of a paddle. What next?

Well, like the ball, we need to make it move around. Only this time, the need to make it move is dependent on those old button press IF Statements from week 2's demonstration of the core loop instead of detecting the pixels. 

To do that, we need to set up a few things. First, we will work on making the paddle move. After that, we will work on the speed and parameters of the paddle itself. Specifically, we'll worry about the size, speed, and behavior of the paddle when it hits the edges. Finally, we will add some style. Specifically, we will add some friction to the paddle to give it a little realism by making it feel heavier. 

### First - We figure out how to move the paddle around. 

We first instantiated the ball in the previous chapter. The principle is the same. We need to account for:
1. the size of the paddle.
1. the shape of the paddle.
1. the position of the paddle.
1. whatever other parameters we need. 
So this seems simple enough. It's just a collection of variables! 

```lua
--paddle starting position
pad_x = 52
pad_y = 120
--paddle speed
pad_dx = 0
--paddle size
pad_w = 24
pad_h = 3
pad_c = 7
```

So here we go. A rectangle's-worth of variables. Starting position in addition to the paddle's width, height, and color. But now, what do we need to do to actually get this object moving? Well, let's take a few stabs at some `if` statements. 

```lua
function _update()
	if btn(0) then
		pad_dx =-5
	end

	if btn(1) then
		pad_dx+=5
	end
	
	pad_x+=pad_dx -- This has to do with where your pad is at!
end
```

So if a button is pressed, the pad's x-axis position is moved either +5 or -5  pixels on the x-axis. It does this by constantly looking for a button press AND by constantly re-declaring `pad_x` as `pad_dx`. But what is `pad_dx`? This is the variable that indicates our speed. This is worth considering independently as the speed and physical parameters of your paddle and ball are yours and yours alone.  

### Second - Next, we think about how fast we want the paddle to be.

```lua
--paddle starting position
pad_x = 52
pad_y = 120
--paddle speed
pad_dx = 0
--paddle size
pad_w = 24
pad_h = 3
pad_c = 7
```
Originally, we declared the paddle speed to be 0. When the variable is adjusted by a button press, it relocates the x-position of the axis because in the update variable, it is re-declared as the variable that is adjusting the x-position of the paddle. The next part of this paddle business is about the sides of the board and the paddle itself.

### Third - We figure out what to do about the sides of the board.

For now, we will not do anything with the paddle and the edge of the board. As this is a breakout game, we should leave the paddle to go past the sides of the screen. Perhaps this is a way to make the game more difficult. Another way to deal with the sides of the board is to make it less likely that the paddle will head outside the board itself. We can do this by adding "friction" of sorts to the paddle itself.

### Finally - Friction and Style!

The easiest way to add friction is through a type of `BOOLEAN` checks to some sort of IF statement. Let's first add a statement that is always false.

```lua 
function _update()
	buttpress = false
```

This allows us to establish a baseline variable that is set to FALSE. This means if we set it to TRUE then a switch is flipped. Let's add a way to deal with it. 

```lua
if not (buttpress) then
	pad_dx = pad_dx/1.7 
end
	pad_x+=pad_dx
```

So this little IF statement is checking the variable `buttpress`. This variable is always set to `false` so each frame, `buttpress` can be nothing but false. This ends up dividing the variable `pad_dx` by 1.7 each frame if the variable is not moving. It does this until it reaches 0. In this way, the paddle will move but the second the button is released, each frame it loses pixel-based movement. 

Play around with it. Change the values, see what makes your game feel the way you want. 

### Putting it all together.

Below is the code that has been outlined above. The techniques and patterns here can be used for any object you'd like to create for players to use. For example, change the paddle to a sprite or some sort of To add to this code, let's walk through each aspect of the cart in order to consider how to add some depth and feel.

You can enter this code into PICO-8's code editor and play around with it. What makes sense? What doesn't? This code has examples from the next couple weeks. Note the very bottom of the code. This is a preview for next week!

```lua
--paddle starting position
pad_x = 52
pad_y = 120
--paddle speed
pad_dx = 0
--paddle size
pad_w = 24
pad_h = 3
pad_c = 7

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

	--turns the ball back to white after the function that turns it red.
	pad_c=7
	--if the ball has hit the paddle, then do something.
	if ball_hit(pad_x,pad_y,pad_w,pad_h) 
	then pad_c = 8
	
	end
end

function _draw()
	--background - ball - paddle
	rectfill(0,0,127,127,1)
	circfill(ball_x,ball_y,ball_r,3)
	rectfill(pad_x, pad_y,pad_x+pad_w,pad_y+pad_h,pad_c)
end

--function for dealing with the ball hitting the box. 
--this will return a value
--can be universal in its instantiation so we can use it in different ways.
function ball_hit(box_x,box_y,box_w,box_h)
	if ball_y - ball_r > box_y + box_h 
	then return false
	end
	if ball_y + ball_r < box_y 
	then return false
	end
	if ball_x - ball_r > box_x + box_w
	then return false
	end
	if ball_x + ball_r < box_x 
	then return false
	end
	return true
end
```
