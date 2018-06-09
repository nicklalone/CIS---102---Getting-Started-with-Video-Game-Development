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
1. Create objects.
1. Do stuff with those objects.
1. Do stuff to those objects.

Sounds goofy, right? But think about it for a second. If we're getting started with a game of breakout, then we need to: 

1. Create a ball and paddle.
1. Do stuff with that ball and paddle (e.g. Make it Move).
1. Do something to the ball and paddle (e.g. Make them hit each other).

And so this week, that's what we'll be doing. 

As an aside, you can read about [other fantasy consoles](/course%20documents/asides/other_readings/Fantasy%20Console%20Wars_%20A%20Guide%20to%20The%20Biggest%20Players%20in%20Retrogaming%E2%80%99s%20Newest%20Trend.pdf). Asides will be those things that you might find interesting given what the current week is meant to teach you but are not essential. You can find all of them in the `Asides` folder in `Course Documents` on the repository. 

As we mentioned last week, PICO-8 was created to emulate the early days of video games. This means that there are no [canned physics engines](), there are no [packages for you to install](). Nothing is done for you. Instead, much like the original game creators, there is just you, your code, and what you see in the game. 

This is important to do as I think for most of us, video games are these multi-million dollar spectacles that require hundreds of thousands of human hours to complete. As a teacher for this course, the hardest thing that I will have to do all semester will be to convince you that the games you play are created the way that they are in this class but at a much larger scale. As a nod to that hurdle, I offer you this tiny essay.

## Getting Over the AAA Experience
As a gamer, I have been playing video games (and board games) since the [Magnavox Odyssey](https://gamehistory.org/first-video-game-commercial/). Starting around 1996, my time with games started to get more intimate. I began to try and make my own games, take other games apart. I started doing this by installing custom Doom wads. Eventually, I graduated to making Quake levels, small RPGs in [RPG=Maker]() and eventually helping friends make their own little games to send to shareware sites. 

For many of you who are undergrads now, that space was around before you were even born. So when I say video game, you might conjure up Playstation 3 or XBox 360 as "old." Time is of course relative. It moves forward constantly but what you are meant to do as someone interested in making games is get into that history and figure out where you belong. It is helpful to know the history of game making in order to understand making games. In many ways, this will be like pulling back the curtain of fantasy to show you the reality. 

This requires two sepcific events: 

1. Dispell the expectation that you can re-create the games you've been playing since you were young.
1. Get you to turn that thing you consume into that thing you are capable of producing.

### item 1: dispelling expectations
It's the second item that makes my job hard. We all want to re-create games we've played before. I can't even tell you how often I hear folks say, "I just want to remake Call of Duty: Modern Warfare." Or, "I loved Grand Theft Auto V and want to make a new one." These are fantastic goals! However, they are also impossible ones. Those games had tens of thousands of hours distributed among hundreds of workers across the fields that comprise or engage computation, marketing, social science, graphic design, and game design.

After all, you're just you and you don't have a few hundred million dollars to spend. So, what I can offer is to get you started on the path so you can join those teams. If I get you on that path, i'm super excited. 

### item 2: flipping the switch to production
To answer number one, i've decided to give the fantasy console the chance it needs - as a space where you can move your consumptive behaviors to production. This is a horribly difficult task for anyone. I was once told that education is the disenchant of the wonder of our childhood. I think this is unfair as for a lot of us, learning how to build the stuff we loved as kids is amazing. What's more adult than making something for others to experience? 

I'm excited because the Fantasy Consoles were created to capture that spirit of creation and discovery that was present before there was a video game industry. 

If you're interested, these books really get in to that space of creation:
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
Looking at PICO-8, you can see that there is a square that everything is drawn on to. Last week when you were playing importing, and manipulating games, you should have noticed that almost all of the games have the same sort of space that things get drawn in. That space looks a little like this: 

![PICO-8 Pixels](/course%20documents/pics/lecture/week2/availablespace.PNG)

There's a lot to break down here. See that little square in the upper left of the big box? That is 1 pixel. There are 128 of those across the screen and 128 of those down the screen. The screen is therefore made into a coordinate system of X (left to right) and Y (top to bottom). (0,0) is the left-most, upper-most pixel whereas (127,127) is the lower-most, right-most pixel. 

You might be asking yourself, "But I thought it was 128 across!!!?" and you're right. But remember that we start at 0, not 1. This is important!

Each of these 128 tiny squares can be up to 16 distinct colors. Each of these has a numeric value. You can see them below:

![PICO-8 Colors](/course%20documents/pics/lecture/week2/colors.PNG)

## Variables
In programming nothing is assumed. If you want a ball, you have to write a number of statements in a programming language that dictate the shape, the size, the speed, and the capabilities of the ball. If you want a blade of grass, you have to write a program that creates it. That program must dictate the color, the size, how many blades of grass. Each of these things are constrained by the hardware and memory allocations available. 

What you are doing in this class, is learning the basics of that process and the place where we can begin is by declaring something exists by creating a variable. Variables are essentially objects that store information. This information is meant to be manipulated later by the computer program. 

Variables can be named anything and form the basis of your own style as a programmer. In PICO-8, there are a lot of different kinds of variables but for now, we can separate these by type. For example, is the variable a number? a collection of characters? a check of true or false? the start of a table? Each of these are possible. 

For now, the types of variables we will concern ourselves with are integers or numbers. Remember the development area?

### Available Space
PICO-8 consists 256 locations. In the upper left is location `(0,0)` and in the lower right is location `(127, 127)`. Remember the map from the last section?

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
1. How fast is the ball? Let's create a variable called `speed = 0`.
1. What color is it? Let's create a variable called `col=4`. Remember that these numbers refer directly to one of the available colors.

After all that we have ourselves a game object!

`circfill(beg_x,beg_y,size,col)` 

Now what do we do with it? Inside our PICO-8 program all it does is draw a dot of a particular color and size in a particular location. How do we get it to *do something*. Well, to get it to start moving, we have to use the game loop.

______

## The Game Loop
The game loop is the central space of interaction of play. For FPS, this is shooting and being shot at. For platformers, this is jumping and landing. Basically, if I as a gamer push a button, then it's important for you to as a gamer to see something happen. There are endless things that are happening in the background for this to occur: 
* The game world has to be drawn on the screen.
* The player must be constantly drawn as they move about the screen.
* The player must be able to press buttons and see a reaction.
* Buttons must be mapped to actions for an input device.
* Enemies, balls, and other obstacles for the player have to be drawn.
* Those same objects need to move according to their AI or physics.
* If online play is happening, the two or more versions of the game must negotiate bandwidth, latency, and discrepancies.

All of the "making" in the phrase "making a game" goes into game loop. This is part of the thing that makes video games feel like games AND makes the idea of creating games hard. Arguably, graphics, narrative, and everything related to that comes second but that is a long discussion that can be read about in this aside. 

In PICO-8, the game loop boils down to 3 key items: initialization, drawing, and updating. 

By default PICO-8 runs at 30 frames per second. This means that that 30 times each second, the game is updated. 

*But what does that mean?* 

That is what this week is about - making sense of the game loop. Let's take a little bit of a tour. We'll borrow this bit of code from the [PICO-8 WIKI](http://pico-8.wikia.com/wiki/GameLoop).

```
-- initialize the position to be the center of the screen
function _init()
  xpos = 64
  ypos = 64
end
 
-- update the position based on the player pressing buttons
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

Well, the PICO-8 Screen is 128 pixels tall and 128 pixels wide though only 127 of each of those is visible. *This is important to remember* and it means that right in the middle of the screen are where these two variables are pointing at, pixel 64 on the X-Axis and pixel 64 on the Y-Axis. 

But what? All you really know is that "Something" has been declared for these two points. In the case of the _INIT() Function, it just means that this is where something will be drawn by the draw function.

## FUNCTION _DRAW()
The Draw function is the second part of the PICO-8 Loop. It is responsible for what it seems like it would be responsible for - drawing things. Take the example we've been working with. Let's take it apart a little. 
```
function _draw()
  cls()
  circfill(xpos, ypos, 10, 8)
end
```
What this seems to be doing is *cls* which is clearing the screen and then *circlfil* which is drawing a circle that begins at those variables that were delcared earlier. The whole line is *circfill(xpos, ypos, 10, 8)* but what does that mean?

Check out the [cheet sheet](https://www.lexaloffle.com/bbs/files/16585/PICO-8_CheatSheet_0111Gm_4k.png) for a little bit about this line. Notice that for the *circfill()* it notes that there is an x-coordinate, a y-coordinate, the radius of the circle, and its color. So what that line is stating is that the circle will be located at *xpos, ypos* (remember those variables from the _init()?) and it will be *10 pixels* wide and a color of 8. Note that on the color portion of the cheet that the color 8 is red. 

There are other aspects of the code as well. Specifically that CLS is interesting. What happens if we take out the clear screen?
```
function _draw()
  circfill(xpos, ypos, 10, 8)
end
```
What happens here is that the screen isn't cleared of the stuff from the other parts of the DRAW() and since it stays there, the circle looks more like a worm than a circle. This is an important lesson! It will come up during your homework. Next, we need to consider the update function. 

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

Note the 127 there. If a specific button is pressed, then something is being done. 

This is our first pattern: variables and the statement IF. 

### FUNCTION _UPDATE60()
Here's a program I wrote to hopefully make a bit more sense. There's something  

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

## IF Statements


## Functions
