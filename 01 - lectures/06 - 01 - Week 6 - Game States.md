For the midterm week, we're going to introduce something that seems easy but can be a little tricky. For a game like breakout! we need to consider the following tasks:
 
1. How do I show a title for my game?
2. How do I maintain a space between the title and the main game?
3. How do I make it so that the player can only play a few times?

The term for these that we'll introduce is _gamestates_. We'll put all we want to create in the front end of this game. 

1. A Title Screen
2. The Main Game
3. "Lives" or Chances
4. Game Over
5. Loop back to the title screen after Game Over

### Preparations to do this.
Before we begin this journey, we need to address the organization of our program. The way that we are beginning can be found inside the code examples portion of the repository. That is the code we will be using to build on. 

The first thing we need to do is move the global variables from outside the main program into the _init function. We will also set a few other variables. 

It should look a little like this: 

```lua
function _init()
 -- first, we clear the screen
 cls()
-- Ball variables.
 ball_x = 50
 x_speed = 2
 ball_y = 100
 y_speed = 2
 ball_size = 3
 col = 0
-- paddle variables
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
```
and so that's our start. However, we need to deal with the start of the game. These functions can be named whatever you want but they will form the basis of the logic through which we work. 

Let's create functions called, 

* `game_over()` which will show after lives are depleted
* `show_menu()` which will show the logo.
* `keep_going()` which will allow us to splash something when a life is lost.
* `run_game()` for when the game is running normally.

These we will control with 3 variables.

* `life`
* `game_done`
* `go_game`

So let's add the first bit to our _init function: 
 
```lua
-- set the start of game to false so the menu shows.
go_game = false
-- set the game_done to false because it isn't over before it's begun.
game_done = false
-- then we go to the show_menu function after initializing.
show_menu()
end
```

And so with that, we can begin to scrape out some things. 

### A Title Screen
This is straight forward enough. We need to show a sprite on the screen. We haven't really mucked about with sprites yet so this might take a bit. For now, we'll just use some text and in the video, i'll show you how to do it with just text.

First, we need to make a function called, `show_menu()` and what the function needs to do is: 

* clear the screen.
* show the title of the game.
* prompt for users to press x to begin.
* do something when the button x is pressed. 

So that looks a little like this. 

```lua
function show_menu()
-- defining the function.
cls()
-- clearing the screen
```
Straight forward so far. 

```lua
print('Bricks!', 40,70,6)
 -- above, we're printing our title screen but you can also make a logo. 
print('press ❎ to begin!',35,80)
-- We then print an instruction to our user.
```
Here, we do something with actual design. We make a decision for buttons and layout! Neat. Next, we have to set up an `if` statement to do something when the user does what we ask them.

```lua
if btn(5) then
-- If the user presses X on the keyboard then,
go_game = true
-- we trigger the start of the game.
buildbricks()
-- run the buildbricks function.
run_game()
-- and begin the actual game.
life = 3
-- We also set lives to 3 and close the function.
end
end
```

The above is a way to get your code organized and the start of your game going. The `if` statement here is waiting for a button press. Once pressed, `if` becomes true and then it all runs. By setting `life` to 3 here, we're anticipating that our user will get 3 chances and that we'll need to reset it here because it is the way the user travels into the main game. 

### The Main Game
This you've already done but you need to do something a little extra...and that is to stick it all in its own. This will look a lot like the below. We've already made this portion of the game and you should recognize it from the _update() function from previous lectures. 

```lua
function run_game()
--this function is the main game. 
-- function ends
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

 if ball_y > 127 then
 game_done = true
 go_game = false
 life = life - 1
 sfx(0)
 end

 if ball_y < 6 
 then y_speed = 2
 sfx(0)
 end

pad_c = 7

if ball_hit(pad_x,pad_y,pad_w,pad_h)
then pad_c = 8
y_speed = -abs(y_speed)
end

for i=1,#brick_x do
  -- check if ball hit brick
  if brick_v[i] and ball_hit(brick_x[i],brick_y[i],brick_w,brick_h) then
  -- if the above statements are true then.
  brick_v[i] = false
  -- make the visibility of the brick false.
  y_speed = -y_speed
  -- reverse the y speed.
  end
end
end
```
And so now, you can see where we're going. We have the "game" in a function by itself and by separating it from the `_update()` function it can be relegated to be stopped at times. Like, for instance, if we want to have a loss of life, end of game, or more. To deal with that, the `_update()` function becomes more of a gatekeeper.

### But what happens to the _update() function?

I called this function a gate keeper. What does that mean? Well, here, we're setting up for 4 things: 

1. Starting the game.
2. Running the game.
2. Losing a Life
3. Ending the game.

To do that, let's think about what that means. We have 2 variables to help us, 3 if we really want to get robust. 

1. `go_game`
2. `game_done`
3. `keep_going`

And so we need to think about them a little. Let's make a table: 

|function|go_game|game_done|additional|
|--------|-------|---------|----------|
|show_menu()|false|false| none|
|run_game()|true|false| none
|keep_going()|false|true| life > 0|
|game_over()|none|none|if life == 0|

So these are the coditions for our 4 functions to fire.

We've already set these with our `_init()` function. In there, we set:

```lua
go_game = false
game_done = false
show_menu()
```
as the final parameters of the `_init()` function. By doing this, we meet the criteria to keep showing the `show_menu()` function. It will be true _until_ someone hits the x button. So let's write that out: 

```lua
function _update()
if go_game == false and game_done == false then show_menu() end
```
And so that's done. We can also write the function that serves as gate keeper of the `run_game()` function. 

```lua
if go_game == true and game_done == false then run_game() end
```
This will allow us to constantly run the `run_game()` function and in this way, we pass through _update whatever is occuring inside of `run_game()`. 

But what about the times we lose a life. What then? Well, for that, we need to interrupt the game. If the game shouldn't keep going and the game (this time) is done AND if we have more than 0 lives, then we need to run to the `keep_going()` function. Let's write that out.

```lua
if go_game == false and game_done == true and life > 0 then keep_going() end
```
And then write out the final `game_over()` function byu saying:

```lua
if life == 0 then game_over() end
end
```
And this looks simple but requires an enormous amount of forethought. We had to create some variables, had to suss out the logic of the various game states we're creating, and how to deal with them. Now, we've set all this up but we need to actually instantiate some of those things. Specifically, the idea of lives and loss of life. 


### "Lives" or Chances
The thing you need to do here is think of this as, "how many times should I allow players to try to finish the initial state?" 

This is your first optional opportunity for `design`. 

### Game Over
After a player runs out of a resource, what happens next? Do you yell at them? Scream at them? Berate them? This is also design. 

### Loop back 
Now that your player has run out of `lives`, what happens next? How can I reset the game? What can I do to reset the game?

