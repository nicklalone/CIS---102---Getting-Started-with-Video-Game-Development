Here's a small demo cart

To start off with I made a simple sprite sheet and map.

function _init()
    x = 64
    y = 48
end

function _draw()
    cls()
    -- draw the map
    map(0,0, 0,0, 16,16)

    -- draw the player
    spr(1, x, y)
end

function _update()
end
So far the player can't move. We can change x and y in the update function to make him move. Let's do x to make him move left and right

function _update()
    if (btn(0)) x-=1
    if (btn(1)) x+=1
end
He moves, but gravity doesn't work yet.

To make gravity work, we'll add a couple more variables. Instead of just having x and y, we'll have a dx and dy. These represent the player's velocity and will be used to update the x and y position each frame.

function _init()
    x = 64
    y = 48
    dx = 0
    dy = 0
end

function _update()
    if (btn(0)) dx=-1
    if (btn(1)) dx=1
    if (not btn(0) and not btn(1)) dx=0

    x += dx
    y += dy
end
Now everything works the same way, we've just changed the buttons to affect dx instead of changing x directly. We'll revisit the buttons after we implement gravity, but let's do that now...

function grounded()
    v = mget(flr(x+4)/8, flr(y)/8+1)
    return fget(v, 0)
end

function _update()
    dx=0
    if (btn(0)) dx=-1
    if (btn(1)) dx=1

    if grounded() then
        dy = 0
        y = flr(flr(y)/8)*8
    else
        dy += 0.98
    end

    x += dx
    y += dy
end
The grounded function checks to see if the player is sitting a square above the ground. mget retrieves the value of a square on the map. We do some math to take the player's position and get that square on the map grid. We use fget to check for sprite flag 0, which I've decided to use to mark solid sprites. So make sure the first flag is set on your sprite if you do this.

The gravity physics come in when we start updating dy each frame. Gravity is an acceleration. On earth it's 9.8 meters per second per second. I plugged in 0.98 pixels per frame per frame here and it worked fine. You can mess with this value to get low gravity, zero gravity, inverted gravity, etc.

The last thing to note here is the snip of code within the if grounded() check. This does some math to adjust his position to make sure he isn't buried in the ground.

With this implemented, we've got basic movement and gravity working!

We can use acceleration for x movement too! This is great for giving your character a feeling of weight. Without it your character will stop on a dime, which doesn't feel natural. Acceleration is a big part of what makes the controls feel so good in Mario games.

function _update()
    -- x acceleration
    ddx = 0
    if (btn(0)) ddx=-.25
    if (btn(1)) ddx=.25

    -- apply x accel
    dx += ddx

    -- limit max speed
    if dx > 3 then
        dx = 3
    elseif dx < -3 then
        dx = -3
    end

    -- drag
    if ddx == 0 then
        dx *= 0.8
    end

    -- y velocity
    if grounded() then
        dy = 0
        -- fix position or else he'll be sunk into floor
        y = flr(flr(y)/8)*8
    else
        -- gravity accel
        dy += 0.98
    end

    -- update position based on vel
    x += dx
    y += dy
end
Finally, we can add jumping. A basic jump is simple but perfecting the feel will take a lot of tweaking.

-- added to _update()
-- y velocity
if grounded() then
    if (btnp(5)) then
        dy=-8
    else
        dy = 0
        -- fix position
        -- or else he'll be sunk into floor
        y = flr(flr(y)/8)*8
    end
else
    -- gravity accel
    dy += 0.98
end
If the player has pressed the button while they are on the ground, we can add an instant change to their velocity to make a jump.

That covers the basics of platformer physics! In the last clip you can see there's still a bunch to do... mostly improving collision detection. The JELPI demo is a great resource for figuring out more about how that can work.

EDIT: fixed some broken image links... apparently I don't know how to imgur

EDIT2: fixed "chugging" motion. The max speed limiting code was resetting the speed down to 1, and then it would accelerate back to 3, and then reset to 1, etc.


-------------------------------------------------------------------------------------------------------------


p1 = {}
p1.x = 64
p1.y = 64
p1.dir = 1

function _init()
	cls()
end


