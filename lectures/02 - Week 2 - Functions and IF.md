**By the end of this week you should be able to:**
1. Name, Save, and Load your PICO-8 files.
1. Write comments in the coding environment.
1. Create and Describe variables 
1. Create rectangles and circles of different colors.
1. Understand the 3 functions of PICO-8's Game Loop.
1. Use IF statements to make objects react to the edges of the screen.

**Optionally, you could also learn to:**
* Install Notepad++ and use it in conjunction with PICO-8.
* Install Sublime Text to use in conjunction with PICO-8

***
# Table of Contents
1. [AAA and You](#getting-over-the-aaa-experience)
1. [The PICO-8 Development Area](#the-pico-8-development-area)
1. [Variables](#variables)
1. [The Game Loop](#the-game-loop)
1. [Other Functions](#functions)
1. [IF Statements](#if-statements)


# Week 2 - IF, Functions and Variables!
There are 3 central concepts this week that will form the basis of the rest of the class: 
1. Declare the existence of objects.
1. Do stuff with those objects.
1. Do stuff to those objects.

Sounds goofy, right? But think about it for a second. If we're getting started with a game of breakout and then pong, we need to take into account how to do these things. Once we get a bit of a, "how to" then we can make unique on our own. To begin, we need to: 

1. Create a ball and paddle.
1. Do stuff with that ball and paddle (e.g. Make it Move).
1. Do something to the ball and paddle (e.g. Make them hit each other).

And so this week, we are getting started with the first item: making things move. 

---
### A Note on "Asides"
Asides will be additional readings and resources about material that is important enough to mention yet not essential to learning how to program. You can find all of them in the `Asides` folder in `Course Documents` on the repository or linked and marked "ASIDE" throughout the lectures for each week.

--- 
### ASIDE - Other Fantasy Consoles

You can read about [other fantasy consoles](/course%20documents/asides/other_readings/Fantasy%20Console%20Wars_%20A%20Guide%20to%20The%20Biggest%20Players%20in%20Retrogaming%E2%80%99s%20Newest%20Trend.pdf) after reading this document.  

PICO-8 was created to emulate the early days of video games. This means that there are no [canned physics engines](), there are no [packages for you to install](). Nothing is done for you. Instead, much like the original game creators, there is just you, your code, and what you see in the game. 

This is important to do as I think for most of us, video games are these multi-million dollar spectacles that require hundreds of thousands of human hours to complete. As a teacher for this course, the hardest thing that I will have to do all semester will be to convince you that the games you play are created the way that they are in this class but at a much larger scale. As a nod to that hurdle, I offer you this tiny essay.

## Getting Over the AAA Experience
There is a space that we need to acknowledge as we get started - the space of needing to grow. For those of us who love video games, this space can be a nightmare. 

As a gamer, I have been playing video games (and board games) since the [Magnavox Odyssey](https://gamehistory.org/first-video-game-commercial/). Starting around 1996, my time with games started to get more intimate. I began to try and make my own games, take other games apart. I started doing this by installing custom Doom wads. Eventually, I graduated to making Quake levels, small RPGs in [RPG-Maker](https://www.rpgmakerweb.com/) and eventually helping friends make their own little games to send to shareware sites. 

For many of you who are undergrads now, that space was around before you were even born. So when I say video game, you might conjure up Playstation 3 or XBox 360 as "old." Time is of course relative. It moves forward constantly but what you are meant to do as someone interested in making games is get into that history and figure out where you belong. It is helpful to know the history of game making in order to understand making games. In many ways, this will be like pulling back the curtain of fantasy to show you the reality. 

This requires two sepcific events: 

1. Dispell the expectation that you can re-create the games you've been playing since you were young.
1. Get you to turn that thing you consume into that thing you are capable of producing.

### item 1: dispelling expectations
It's the second item that makes my job hard. We all want to re-create games we've played before. I can't even tell you how often I hear folks say, "I just want to remake Call of Duty: Modern Warfare." Or, "I loved Grand Theft Auto V and want to make a new one." These are fantastic goals! However, they are also impossible ones. Those games had tens of thousands of hours distributed among hundreds of workers across the fields that comprise or engage computation, marketing, social science, graphic design, and game design.

After all, you're just you and you don't have a few hundred million dollars to spend. So, what I can offer is to get you started on the path so you can join those teams. If I get you on that path, i'm super excited. 

### item 2: flipping the switch to production
To answer number one, i've decided to give the fantasy console the chance it needs - as a space where you can move your consumptive behaviors to production. This is a horribly difficult task for anyone. I was once told that education is the disenchant of the wonder of our childhood. I think this is unfair as for a lot of us, learning how to build the stuff we loved as kids is amazing. What's more adult than making something for others to experience? 

### This is where Fantasy Consoles come in
I'm excited about this class and what we're about to do because the Fantasy Consoles were created to capture that spirit of creation and discovery that was present before there was a video game industry. Exploration, severe limitations, and endless possibilities are what define this era. 

If you've never experienced this era but you're interested, these books really get in to that space of creation:
* [Dungeon Hacks: How NetHack, Angband, and Other Roguelikes Changed the Course of Video Games](https://www.amazon.com/Dungeon-Hacks-NetHack-Angband-Roguelikes-ebook/dp/B012QP0Z7O/ref=sr_1_4?ie=UTF8&qid=1525273115&sr=8-4&keywords=roguelike)
* [Masters of Doom: How Two Guys Created an Empire and Transformed Pop Culture](https://www.amazon.com/Masters-Doom-Created-Transformed-Culture/dp/0812972155/ref=sr_1_1?ie=UTF8&qid=1525273157&sr=8-1&keywords=masters+of+doom)
* [The Friendly Orange Glow: The Untold Story of the PLATO System and the Dawn of Cyberculture](https://www.amazon.com/Friendly-Orange-Glow-Untold-Cyberculture/dp/1101871555/ref=sr_1_1?ie=UTF8&qid=1525273782&sr=8-1&keywords=the+friendly+orange+glow)

### A pointer before we continue.
___
A lot of what we'll go over here today is also captured on [this wiki page](http://pico-8.wikia.com/wiki/Lua). 

____
#### admin note:
*If you'd like to try and jump ahead you can, but just know that you'll be expected to meet the requirements of your homework each week. This means you'll have to point out things in your code via comments and line numbers.*
____

## The PICO-8 Development Area
Looking at PICO-8, you can see that there is a square that everything is drawn on to. Last week when you were playing importing, and manipulating games, you should have noticed that almost all of the games have the same sort of area that things get drawn in. That area looks a little like this: 

![PICO-8 Pixels](/course%20documents/pics/lecture/week2/availablespace.PNG)

There's a lot to break down here. See that little square in the upper left of the big box? That is 1 pixel. There are 128 of those across the screen and 128 of those down the screen. The screen is therefore made into a coordinate system of X (left to right) and Y (top to bottom). (0,0) is the left-most, upper-most pixel whereas (127,127) is the lower-most, right-most pixel. 

You might be asking yourself, "But I thought it was 128 across!!!?" and you're right. But remember that we start at 0, not 1. This is important! I won't do it but there should be italics, bold text, exclamation points and more on this point. I will repeat it at least 5 more times.

Each of these 128 tiny squares can be up to 16 distinct colors. Each of these has a numeric value. You can see them below:

![PICO-8 Colors](/course%20documents/pics/lecture/week2/colors.PNG)

## Variables
*In programming nothing is assumed.* If you want a ball, you have to write a number of arguments in a programming language that dictate the shape, the size, the speed, and the capabilities of the ball. If you want a blade of grass, you have to write a program that creates it. That program must dictate the color, the size, how many blades of grass. Each of these things are constrained by the hardware and memory available. 

What you are doing in this class, is learning the basics of that process and *the place where we can begin* is by declaring something exists by creating a variable. Variables are essentially objects that store information. This information is meant to be manipulated later by the computer program. 

Variables can be named anything and form the basis of your own style as a programmer. In PICO-8, there are a lot of different kinds of variables but for now, we can separate these by type. For example, is the variable a number? a collection of characters that we will refer to as strings? a check of true or false called a boolean check? the start of a table of data? Each of these are possible. 

For now, the types of variables we will concern ourselves with are integers or numbers. Remember the development area?

### Available Space
PICO-8 consists 256 locations. Because we start at 0, the upper left location is `(0,0)` and the lower right location is `(127, 127)`. Remember the map from the last section?

![PICO-8 Pixels](/course%20documents/pics/lecture/week2/availablespace.PNG) 

Well, this is the space you can work with. Do you want to have a dot that moves around the screen like a ball? Well, you can use `circfill()` to create a tiny circle but you have to deal with a number of things. 
1. Where does the ball begin?
1. How big is the ball?
1. How fast is the ball?
1. What happens to the ball if it reaches the edge of the screen?
1. What color is it?
1. Does it make a sound?

Using the above collection of x and y coordinates, we can answer a few of those things. 
1. Where does the ball begin?
1. How big is the ball?
1. How fast is the ball?

We know the command `circfill()` can help us a lot. `circfill(x,y,r,[col])` are all of the parameters for us. Let's assign some variables to them: 

1. Where does the ball begin? Let's create 2 variables for the 2 coordinates x and y: `beg_x = 64` and `beg_y = 64`.
1. How big is the ball? Let's create a variable called `size = 3`. This will be our `radius` or `r`.
1. What color is it? Let's create a variable called `col=4`. Remember that these numbers refer directly to one of the available colors.
1. How fast is the ball? Let's create a variable called `speed = 0`.

After all that we have ourselves a game object! You just put the variables in the `(x,y,r,[col])` spaces. It'll look something like:

`circfill(beg_x,beg_y,size,col)` 

Now what do we do with it? 

Inside our PICO-8 program all it does is draw a dot of a particular color and size in a particular location. How do we get it to *do something*. Well, to get it to start moving, we have to use the game loop.

______

## The Game Loop
*The game loop is the central loop of your code - you initialize the game screen, draw objects, and then update those objects. This is often tied in to a game's core mechanic. For example, in first-person shooters, the player shoots and is shot at. For platformers, this is jumping and landing. 

Basically, if I as a gamer push a button, then it's important for you to as a gamer to see something happen. There are endless things that are happening through your code that makes this to occur. For example, every single frame (in this case, we'll say 30 or 60 frames per second): 
* The game world has to be drawn on the screen.
* The player must drawn indicating movement.
* The player must be able to press buttons and see a reaction.
* Buttons must be mapped to actions for an input device.
* Enemies, balls, and other obstacles for the player have to be drawn.
* Those same objects need to move according to their AI or physics.
* If online play is happening, the two or more versions of the game must negotiate bandwidth, latency, and discrepancies between machines, service providers, and more.

All of the "making" in the phrase ""making a game" goes into the game loop which is also tied to the "core mechanics. This is part of the thing that makes video games feel like games AND makes the idea of creating games hard. 

In PICO-8, like all other games, the loop boils down to 3 key items: initialization, drawing, and updating. As an **ASIDE** you can read about the [Game Loop](https://gamedevelopment.tutsplus.com/articles/gamedev-glossary-what-is-the-game-loop--gamedev-2469) here. 

By default PICO-8 runs at 30 frames per second. This means that that 30 times each second, the game is updated. 

*But what does that mean?* 

That is what this week is about - making sense of the game loop. Let's take a little bit of a tour. We'll borrow this bit of code from the [PICO-8 WIKI](http://pico-8.wikia.com/wiki/GameLoop). 

*Some of the code here might not make sense but it will by the time we are done. The reason we are pasting this in is so we can make sense of what is going on here. This is our structure for coding everything.*

```
-- the first thing we do is initialize the position 
-- of where we'll be drawing something. 
-- In this case, it will  to be the center of the screen
function _init()
  xpos = 64
  ypos = 64
end
 
-- we then update the position based on the player pressing buttons
-- this is for up down left and right
function _update()
  if (btn(0) and xpos > 0) xpos -= 1
  if (btn(1) and xpos < 127) xpos += 1
  if (btn(2) and ypos > 0) ypos -= 1
  if (btn(3) and ypos < 127) ypos += 1
end
 
-- clear the screen, then draw a circle at the current position
function _draw()
  cls()
  circfill(xpos, ypos, 10, 8)
end
```
This code should be pretty straight forward. Copy it and paste it into your Code Editor. When you click run, it should look like this: 

![The Game Loop](/course%20documents/pics/lecture/week2/func.gif)

## FUNCTION _INIT()
This function runs as the game begins. It is doing stuff to initialize your game. In this case, notice the code: 
```
function _init()
  xpos = 64
  ypos = 64
end
```
The first part of that code, function _init() is us creating that function. We are definine that a function called _init. Everything after the () is what that function contains. For now, we won't say more about the () except for the fact that you need them in order for it to work. 

The next part is: 
```
  xpos = 64
  ypos = 64
```
We call these two lines of code variables. The first is the variable *xpos* and the second is the variable *ypos*. Each of these exist *only* inside the _INIT() function right now. There are other types of variables that we will get to soon. 

But what does that mean? 2 variables declared for 64 and 64 what? 

Well, the PICO-8 Screen is 128 pixels tall and 128 pixels wide. *Do not forget that we start at 0 and go to 127 rather than 1 to 128.* These pixels begin with *This is important to remember* and it means that right in the middle of the screen are where these two variables are pointing at, pixel 64 on the X-Axis and pixel 64 on the Y-Axis. 

But what? All you really know is that "Something" has been declared for these two points. In the case of the _INIT() Function, it just means that this is where something will be drawn by the draw function.

## FUNCTION _DRAW()
The Draw function is the second part of the PICO-8 Loop. It is responsible for what it seems like it would be responsible for - drawing things. Take the example we've been working with. Let's take it apart a little. 
```
function _draw()
  cls()
  circfill(xpos, ypos, 10, 8)
end
```
What this seems to be doing is *cls* which is `cl`earing the `s`creen and then *circlfil* which is drawing a circle that begins at those variables that were delcared earlier. The whole line is *circfill(xpos, ypos, 10, 8)* but what does that mean?

Check out the [cheet sheet](https://www.lexaloffle.com/bbs/files/16585/PICO-8_CheatSheet_0111Gm_4k.png) for a little bit about this line. Notice that for the *circfill()* it notes that there is an x-coordinate, a y-coordinate, the radius of the circle, and its color. So what that line is stating is that the circle will be located at *xpos, ypos* (remember those variables from the _init()?) and it will be *10 pixels* wide and a color of 8. Note that on the color portion of the cheet that the color 8 is red. 

There are other aspects of the code as well. Specifically that CLS is interesting. What happens if we take out the clear screen?
```
function _draw()
  circfill(xpos, ypos, 10, 8)
end
```
What happens here is that the screen isn't cleared of the stuff from the other parts of the DRAW() and since it stays there, the circle looks more like a worm than a circle. This is an important lesson! It will come up during your homework. 

Let's go to the next part of the loop, _update().


## FUNCTION _UPDATE() AND FUNCTION UPDATE60()
The *_UPDATE* function is just that, it updates the game each frame based on the code within. In this case, this is not a function for drawing things, but for doing stuff. Notice the code from the cart that started this discussion:

```
function _update()
  if (btn(0) and xpos > 0) xpos -= 1
  if (btn(1) and xpos < 127) xpos += 1
  if (btn(2) and ypos > 0) ypos -= 1
  if (btn(3) and ypos < 127) ypos += 1
end
```
What is happening here is that the UPDATE() function is that each frame the program checks if a button has been pressed. If it has, it adds or subtracts 1 from the xpos/ypos variables. Notice that in this case, the circle itself is not moving but the space where it is initialized is. The circle just happens to be assigned those two variables. 

Note the 127 there. If a specific button is pressed, then something is being done. To demonstrate just what is going on, let's take that same program and manipulate it it a bit. To do this, we need to think GLOBAL. 

### Local Variables versus Global Variables
So, this is a place where we could insert something as we go through this particular code. In the example, everything is located inside of the functions. However, not everything will live in there. This is where we define two kinds of variables: Global and Local.

Let's take another example of that program: 
```
-- the first thing we do is initialize the position 
-- of where we'll be drawing something. 
-- In this case, it will  to be the center of the screen
function _init()
  xpos = 64
  ypos = 64
end
 
-- we then update the position based on the player pressing buttons
-- this is for up down left and right
function _update()
  if (btn(0) and xpos > 0) xpos -= 1
  if (btn(1) and xpos < 127) xpos += 1
  if (btn(2) and ypos > 0) ypos -= 1
  if (btn(3) and ypos < 127) ypos += 1
end
 
-- clear the screen, then draw a circle at the current position
function _draw()
  circfill(xpos, ypos, 10, 8)
end
```

Let's say we want to make it so that each time the frame updates, it pushes the color of the circle closer to the next color. To deal with this, we have to create a global variable. For the purposes of this example, we'll call it `col = 0`. This makes the little program we're working on look like this: 

```
col = 0
-- the first thing we do is initialize the position 
-- of where we'll be drawing something. 
-- In this case, it will  to be the center of the screen
function _init()
  xpos = 64
  ypos = 64
end
 
-- we then update the position based on the player pressing buttons
-- this is for up down left and right
function _update()
  if (btn(0) and xpos > 0) xpos -= 1
  if (btn(1) and xpos < 127) xpos += 1
  if (btn(2) and ypos > 0) ypos -= 1
  if (btn(3) and ypos < 127) ypos += 1
  col = col+.25
end
 
-- clear the screen, then draw a circle at the current position
function _draw()
  circfill(xpos, ypos, 10, 8)
end
```
So ok, we have a variable called col that exists outside of the game loop and is not part of any other function. This is a GLOBAL variable. We can manipulate it from aby of the 3 parts of the loop. For example, if we want to make it shift colors, we have to manipulate that variable each time the frame updates BUT ALSO use it as a declaration of color in the `circfill()` function. So:

```
col = 0
-- the first thing we do is initialize the position 
-- of where we'll be drawing something. 
-- In this case, it will  to be the center of the screen
function _init()
  xpos = 64
  ypos = 64
end
 
-- we then update the position based on the player pressing buttons
-- this is for up down left and right
function _update()
  if (btn(0) and xpos > 0) xpos -= 1
  if (btn(1) and xpos < 127) xpos += 1
  if (btn(2) and ypos > 0) ypos -= 1
  if (btn(3) and ypos < 127) ypos += 1
  col = col+.25
end
 
-- clear the screen, then draw a circle at the current position
function _draw()
  circfill(xpos, ypos, 10, col)
end
```

NEAT! Notice how it slowly cycles through the colors. Think of the process like this: 
```
COLOR = 0
FRAME UPDATE
COLOR = 0.25
FRAME UPDATE
COLOR = 0.50
FRAME UPDATE
COLOR = 0.75
FRAME UPDATE
COLOR = 1
```
30 times a second, the COL variable is gaining .25 so every 4 frames it changes colors. You can increase and decrease this number as you like. 

Next, we need to consider the update function. 

### FUNCTION _UPDATE60()
Now, by default, PICO-8 updates 30 times per second. This is 30 frames per second. However, it can also move faster if you like. There are multiple reasons for this, multiple ways that it can work. Maybe you want smoother, maybe you need quicker calculations, maybe your sprites need to animate faster (we'll get to that) but it exists if you need it. To demonstrate it, here's a program I wrote to hopefully make a bit more sense. First, we'll start in 30 frames:

```
posx = 0
posy = 0
col = 0

function _init()
cls()
end

function _update()
-- print('hello, i am an update function')
	rectfill(posx,posy,posx,posy,col)
	posx = posx+1
	col = col+1
	if posx >= 127 
	then posy = posy+1 end
	if posx >=127
	then posx = 0 end
end

function _draw()
-- Will leave this here for later / fiddling.
end
```

![The Game Loop](/course%20documents/pics/lecture/week2/screenfill.gif)

But what happens if we instead use the 60 updates per second FUNCTION _UPDATE60()? 

![The Game Loop](/course%20documents/pics/lecture/week2/screenfill60.gif)

Does it seem twice  as fast? It should because it is. Frame rates also impact other things like variables, IF Statements and Functions. We've covered variables and you know what functions are frome the game loop, but what else can those do? But first, lets actually explore those IF Statements that are part of the "moving the circle" part of the program update.

## IF Statements
An IF statement is just how it seems. IF sonething happens, THEN do something else. In the example above, the program called for the circle that was being drawn to move IF something pressed a button. 

We can manipulate this a little bit more to make things look a little more dynamic. Let's synthesize everything we've been doing and try our hand and making a ball.

What is happening here?
```
ball_x = 44.76
x_speed = 2
ball_y = 5.88
y_speed = 2
ball_round = 3
col = 0

function _init()
cls()
end

function _update()
ball_y = ball_y+y_speed
ball_x = ball_x+x_speed
col=col+1

if ball_x > 127 
then x_speed = -2 
end

if ball_x < 0 
then x_speed = 2
end

if ball_y > 127 
then y_speed = -2 
end

if ball_y < 0 
then y_speed = 2
end
end

function _draw()
cls()
circfill(ball_x,ball_y,ball_round,col)
end
```
So what is happening here? Well, if you plugged this into your PICO-8 code editor you'd see a flashing ball that ends up bouncing around he screen. Why does it do this? Can you work out why?

Those IF statements tell us a story. As the ball object, that `circfill()` in the `_draw()` function, the values change because of the increments in the `_update()` function. We are adding two values together to adjust the circles `ball_x` and `ball_y` values. 

This means that as the `circfill()` object is drawn, it appears to move. 30 times a second, the value shifts. So in this way, the circle seems to move. 30 pixels per second. So take a look those IF Statements. They ,ight make a bit of logical sense. 

What they say is this: *If the variable that indicates the x or y position of the ball is ever greater (>) than the edge of the screen, then change the speed value to the opposite of what it was.*

This is powerful. It gives our ball the ability to seem like it's bouncing off of the walls. But this is not the only thing you can do with IF statements. We can use them for anything we need to check for. 

The last thing we will cover are FUNCTIONS. You've already been using them so let's dig in a little.

Now what are Functions?

## Functions
Functions are what they seem, groups of commands that produce or return something. We are going to concern ourselves with 2 kinds of functions: API Functions (we could also call these "internal" functions) and functions we create ourselves. 

### API Functions
By now, you have been using a number of API Functions. These are things like `circlfill()` or `_update()`. You can tell that these are functions because they end with a (). That little group of parentheses indicates that something is going to exist inside that function. 

There is a great list of these here: [http://pico-8.wikia.com/wiki/APIReference](http://pico-8.wikia.com/wiki/APIReference). All of these can give you a lot to play with. You can explore these as you desire and use them how you see fit.

The second type of function are the kinds that we define ourselves. For example, we can add a function called, `runsinit()` that prints a few lines of text. 

```
ball_x = 44.76
x_speed = 2
ball_y = 5.88
y_speed = 2
ball_round = 3
col = 0

function runsinit()
print('this is its own function')
print('😐😐😐😐😐😐😐😐')
print('love it!')
end

function _init()
cls()
runsinit()
end

function _update()
ball_y = ball_y+y_speed
ball_x = ball_x+x_speed
col+=1

if ball_x > 127 
then x_speed = -2 
end

if ball_x < 0 
then x_speed = 2
end

if ball_y > 127 
then y_speed = -2 
end

if ball_y < 0 
then y_speed = 2
end
end

function _draw()
print('what is up',ball_x,ball_y,col)
end
```

So what happened up there? We defined a function by writing this line: 
`function runsinit()`. Doing this opens up PICO-8's function parameters. Everything we type into this function before the words `end` will run as we need. So notice inside of the _init() function we call upon the `runsinit()` function. If you run this program, what happens?

### Wrapping it up
This week, we have gone through the game loop. We also went over variables, functions, and briefly explored IF statements. So now, it's up to you to put them together. Take your first steps into programming, into design!

One last thing to keep in mind. This stuff is hard. Really, really hard. This is ok. Difficult is good. But it's also discouraging. We all love games, we play games made by thousands of people who all use millions of dollars to meticulously create code, models, and loops to take advantage of the nearly endless resources available in the latest models of processors and machines. 

You, you're one person who is using a computer that cost a lot of money making squares and circles wander around a tiny screen. More than that, maybe that's all you can do and you don't understand why these things are working the way they are. 

That is ok.

I listen to this video every week or two. It helps when i'm feeling discouraged by the things I have to do. [Ira Glass on Storytelling](https://vimeo.com/24715531).

Replace storytelling with game making. But what about taste? Do you play other games? What sort of taste do you have about games? As an **ASIDE**, consider [this list of games]() that are currently at the forefront of edgy, innovative games. I recommend playing one or two of them a week. What do they share? What sets them apart?






