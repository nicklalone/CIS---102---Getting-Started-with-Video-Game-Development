**By the end of this week you should be able to:**
1. Name, Save, and Load your PICO-8 files.
1. Write comments in the coding environment.
1. Create and Describe variables 
1. Create rectangles and circles of different colors.
1. Understand the 3 functions of PICO-8's Game Loop.
1. Use IF statements to make objects react to the edges of the screen.

**Optionally, you could also learn to:**
1. Install Notepad++ and use it in conjunction with PICO-8.
1. Install Sublime Text to use in conjunction with PICO-8

# Week 2 - IF, Functions and Variables!
There are 3 central concepts this week that will form the basis of the rest of the class: 
1. Create objects.
1. Do stuff with those objects.
1. Do stuff to those objects.

Sounds goofy, right? But think about it for a second. If we're getting started with a game of breakout, then we need to: 

1. Create a ball and paddle.
1. Do stuff with that ball and paddle.
1. Do something to the ball and paddle.

And so this week, that's what we'll be doing. As an aside, you can read about other development environments, but for now, we'll be talking about PICO-8. This console was created to emulate the early days of video games. This means that there are no canned physics engines, there are no packages for you to install. There is just you, your code, and what you see in the game. This is important to do as I think for most of us, video games are these multi-million dollar spectacles that require hundreds of thousands of human hours to complete. This reminds me.

## Getting Over the AAA Experience
As a gamer, I have been inside the world of video games (and board games) since the [Magnavox Odyssey](https://gamehistory.org/first-video-game-commercial/) was new. I've been inside of the creation of video games since around the late 1990s when I started making Quake levels and helping friends make their own little games to send to shareware sites. For many of you who are undergrads now, that space was around before you were even born. So when I say video game, you might conjure up Playstation 3 or XBox 360 as "old." But in order to make games, that history needs to be considered as a starting point. 

With that in mind, my job as the insructor for this course is to deal with two sepcific things: 

1. Get you to turn that thing you consume into that thing you are capable of producing.
1. Dispell the expectation that you can re-create the games you've been playing since you were young.

### item 2: dispelling expectations
It's the second item that makes my job hard. We all want to re-create games we've played before. I can't even tell you how often I hear folks say, "I just want to remake Call of Duty: Modern Warfare." Or, "I loved Grand Theft Auto V and want to make a new one." These are fantastic goals! However, they are also impossible ones. Those games had tens of thousands of hours distributed among hundreds of workers across the fields that comprise or engage computation, marketing, social science, graphic design, and game design.

After all, you're just you and you don't have a few hundred million dollars to spend. So, what I can offer is to get you started on the path so you can join those teams. If I get you on that path, i'm super excited. 

### item 1: flipping the switch to production
To answer number one, i've decided to give the fantasy console the chance it needs - as a space where you can move your consumptive behaviors to production. This is a horribly difficult task for anyone. I was once told that education is the disenchant of the wonder of our childhood. I think this is unfair as for a lot of us, learning how to build the stuff we loved as kids is amazing. What's more adult than making something for others to experience? 

I'm excited because the Fantasy Consoles were created to capture that spirit of creation and discovery that was present before there was a video game industry. 

If you're interested, these books really get in to that space of creation:
* [Dungeon Hacks: How NetHack, Angband, and Other Roguelikes Changed the Course of Video Games](https://www.amazon.com/Dungeon-Hacks-NetHack-Angband-Roguelikes-ebook/dp/B012QP0Z7O/ref=sr_1_4?ie=UTF8&qid=1525273115&sr=8-4&keywords=roguelike)
* [Masters of Doom: How Two Guys Created an Empire and Transformed Pop Culture](https://www.amazon.com/Masters-Doom-Created-Transformed-Culture/dp/0812972155/ref=sr_1_1?ie=UTF8&qid=1525273157&sr=8-1&keywords=masters+of+doom)
* [The Friendly Orange Glow: The Untold Story of the PLATO System and the Dawn of Cyberculture](https://www.amazon.com/Friendly-Orange-Glow-Untold-Cyberculture/dp/1101871555/ref=sr_1_1?ie=UTF8&qid=1525273782&sr=8-1&keywords=the+friendly+orange+glow)

***
# Table of Contents
1. [Game Loops](#game-loops)
1. [Variables](#variables)
1. [Functions](#functions)
1. [IF Statements](#if-statements)

A lot of what we'll go over here today is also captured on [this wiki page](http://pico-8.wikia.com/wiki/Lua). If you'd like to try and jump ahead you can, but just know that you'll be expected to meet the requirements of your homework each week. This means you'll have to point out things in your code via comments and line numbers.

## Game Loops
The game loop is the central space of interaction of play. For FPS, this is shooting and being shot at. For platformers, this is jumping and landing. Basically, if I as a gamer push a button, then it's important for you to as a gamer to see something happen. There are endless things that are happening in the background for this to occur: 
* The game world has to be rendered (drawn).
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
This code should be pretty straight forward, it looks a bit like this: 

![The Game Loop](course%20documents/pics/lecture/week2/func.gif)

## Function _INIT()
This function fires when the game begins 

## Function _DRAW()

## Function _UPDATE()

