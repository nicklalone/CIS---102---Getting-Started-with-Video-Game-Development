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
3 items form the basis of this week's lesson. THey all surround the idea of making things hit each other. 
1. Using IF Statements in more creative ways.
1. Make pre-defined objects interact with each other in predictible ways.
1. Optionally Using the Sprite Editor

This week's lesson might be the most difficult of the semester. Do not worry, you will have enough examples to pull from should you need them. There are also numerous code examples to pull ideas from. As always, should you pull from these, remember to mark in comments that you used ideas from the code examples. In particular, note which ones you did use. 

---

# What does it mean 


https://developer.mozilla.org/en-US/docs/Games/Techniques/2D_collision_detection


Example to build on. 

* If you have two boxes A and B: 
* if the right side of A is to the left of the left side of B, they can't possibly be colliding. 
* if the left side of A is to the right of the right side of B, 
* and the analogous top/bottom cases. 

check whether any of the four definitely-not-colliding cases is true and then stop.

```
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

```
function colliding(a, b)
    if a.x > b.x + b.w - 1 then return false end
    if a.y > b.y + b.h - 1 then return false end
    if a.x + a.w - 1 < b.x then return false end
    if a.y + a.h - 1 < b.y then return false end
    return true
end
```
https://www.lexaloffle.com/bbs/?tid=3116

```
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
