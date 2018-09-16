**By the end of this lesson, you will be able to:**
1. Create objects that interact.
1. Use variables and if statements to make two objects that interact.
1. Use the sprite editor to create objects that interact.
1. Assign states to sprites. 

**Optionally, you could also learn to:**
1. Create a rudimentary outline for a platformer
1. Upload a cart to PICO-8
1. Send PICO-8 data to Github.

**Table of Contents**
1. [What does collision mean?](#what-does-it-mean?)
1. [Using IF Statements to Make Things Interact](#using-if-statements-to-make-things-interact)
1. [Using the Sprite System to Make Thing Interact](#using-the-sprite-system-to-make-things-interact)
1. [Code Beyond Your Computer](#code-beyond-your-computer)

# Week 4 - Making Stuff Collide with Things
3 items form the basis of this week's lesson. They all surround the idea of making things hit each other. 
1. Using IF Statements in more creative ways.
1. Make pre-defined objects interact with each other in predictible ways.
1. Optionally Using the Sprite Editor

I will tell you now that this week's lesson might be the most difficult of the semester. It is difficult _because_ what we're going to cover this week has been completely encapsulated by black boxes. This means that in products like Unity or Unreal Engine 4, you click a button that makes a particular object "RIGID" or "Have mass". You can also click on buttons that call particular objects a "ball" or something like it. 

In PICO-8, none of these pre-packaged entities exist so all that you are left with is you, yourself, and your code. However, while it is difficult, if you can get this, you're well on your way to understanding the _super important_ relationship between code and game. 

As always, you will have examples to pull from should you need them. Since this topic is so rough, there are also numerous code examples to pull ideas from. It is this concept that gets poached _the most_ by new programmers. As always, should you pull from these, remember to mark in comments that you used ideas from the code examples. In particular, note which ones you did use. 

---

# What does it mean 

In your game examples for week 3, you might have noticed that nothing really happens when the ball and the paddle touch one another. Additionally, you might have also noticed in week 2 that your ball couldn't detect the side of the screen unless you specifically told it to. 

For what we're doing today, I want you to consider this example. Don't worry about the code itself or what language it is, just look at it generically. 

[The example is here \(click on this\)](https://developer.mozilla.org/en-US/docs/Games/Techniques/2D_collision_detection)

What did you notice? How did it work? Everything you need is located: 

```javascript 
if (rect1.x < rect2.x + rect2.w &&
        rect1.x + rect1.w > rect2.x &&
        rect1.y < rect2.y + rect2.h &&
        rect1.h + rect1.y > rect2.y)
```

What does this say, exactly? Read it from left to right: 

```
If rectangle 1's x-axis value is less than rectangle 2's x-axis value + the width of rectangle 2, 
OR If rectangle 1's x-axis value plus rectangle 1's width is greater than rectangle 2's x-axis value, 
OR if rectangle 1's y-axis value is less than rectangle 2's y-axis value + rectangle 2's height, 
OR if rectangle 1's height plus rectangle 1's y-axis value is greater than rectangle 2's y-axis value, 

THEN it is a collision. 
```

That's a lot but think about it individually. Really it's saying if any part of rectangle 1 overlaps with any part of rectangle 2, that is a collision and something should happen. What should happen? `this.color("green");` or Turn Rectangle 1 green. 

You're going to work on your paddle and ball combination the same way. Let me recommend a few things: 

1. Start early.
1. Take it slow.
1. No really, take it slow.
1. Write it all out on paper first.
1. Type it out in "pseudo-code" (like my example above with the 4 sentences)
1. Incrementally add to your code.
1. If you get frustrated, walk away for a while.

# Using IF Statements to Make Things Interact

So we're going to be building on our breakout example because it allows us to contextualize what we're doing, you can find a ton of other examples, and it should end up standardizing those of you looking for help. 

Let's start with a "pseudo-code" example to build on. 

* If you have two boxes A and B: 
* if the right side of A is to the left of the left side of B, they can't possibly be colliding. 
* if the left side of A is to the right of the right side of B, 
* and the analogous top/bottom cases. 

check whether any of the four definitely-not-colliding cases is true and then stop.

```lua
function colliding(a, b)
    if a.x > b.x + b.w - 1 then return false end
    if a.y > b.y + b.h - 1 then return false end
    if a.x + a.w - 1 < b.x then return false end
    if a.y + a.h - 1 < b.y then return false end
    return true
end
```

where x and y are the top left corner of the sprite 
the same coordinates you use to `spr()` it)  and w and h are its width and height 
if those are always 8 you can hardcode it

```lua
function colliding(a, b)
    if a.x > b.x + b.w - 1 then return false end
    if a.y > b.y + b.h - 1 then return false end
    if a.x + a.w - 1 < b.x then return false end
    if a.y + a.h - 1 < b.y then return false end
    return true
end
```
https://www.lexaloffle.com/bbs/?tid=3116

```lua
function _init()
	w=128 -- width of the game map
	h=128 -- height of the game map
	player={}
	player.x=0
	player.y=0
	-- collide with map tiles?
	player.cm=true
	-- collide with world bounds?
	player.cw=true
end

function _update()
	cls()
	map(0,0,0,0,16,16)
	move(player)
	spr(0,player.x,player.y)
end

function cmap(o)
	local ct=false
	local cb=false

	-- if colliding with map tiles
	if(o.cm) then
		local x1=o.x/8
		local y1=o.y/8
		local x2=(o.x+7)/8
		local y2=(o.y+7)/8
 	local a=fget(mget(x1,y1),0)
 	local b=fget(mget(x1,y2),0)
 	local c=fget(mget(x2,y2),0)
 	local d=fget(mget(x2,y1),0)
 	ct=a or b or c or d
 end
 -- if colliding world bounds
 if(o.cw) then
 	cb=(o.x<0 or o.x+8>w or
						o.y<0 or o.y+8>h)
 end

 return ct or cb
end

function move(o)
 local lx=o.x -- last x
 local ly=o.y -- last y

 if(btn(0)) o.x-=1
 if(btn(1)) o.x+=1
 if(btn(2)) o.y-=1
 if(btn(3)) o.y+=1

 -- collision, move back
 if(cmap(o)) o.x=lx o.y=ly
end
```

This is where we're starting. Let's walk through this so we can begin. Let's take a walk through these data. 

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
