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
