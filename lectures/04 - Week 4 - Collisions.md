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
if those are always 8 you can hardcode it :slightly_smiling_face:

```
function colliding(a, b)
    if a.x > b.x + b.w - 1 then return false end
    if a.y > b.y + b.h - 1 then return false end
    if a.x + a.w - 1 < b.x then return false end
    if a.y + a.h - 1 < b.y then return false end
    return true
end
```
