```
function colliding(a, b)
    if a.x > b.x + b.w - 1 then return false end
    if a.y > b.y + b.h - 1 then return false end
    if a.x + a.w - 1 < b.x then return false end
    if a.y + a.h - 1 < b.y then return false end
    return true
end
```
