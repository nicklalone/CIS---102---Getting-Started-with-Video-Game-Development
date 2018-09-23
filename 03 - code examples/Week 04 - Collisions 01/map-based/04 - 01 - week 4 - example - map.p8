-- can set up 2 functions and call them by update and draw.
scrn = {}
p1 = {}

function _init()
	show_menu()
end

function _update()
	scrn.upd()
end

function _draw()
	scrn.drw()
end
	
function show_menu()
	scrn.upd = update_menu
	scrn.drw = draw_menu
	cls()
end

function update_menu()
	if (btn(4)) then run_game() end
end

function draw_menu()
	print('press z to start.',30,50,7)
end

function run_game()
	scrn.upd = update_game
	scrn.drw = draw_game
	
	p1.x = 64
	p1.y = 64
	p1.dir = 1
	
	cls()
end

function update_game()
	-- right
	if (p1.dir == 2) then p1.x = p1.x + 1 end
	-- left
	if (p1.dir == 4) then p1.x = p1.x - 1 end
	-- up
	if (p1.dir == 1) then p1.y = p1.y - 1 end
	-- down
	if (p1.dir == 3) then p1.y = p1.y + 1 end

	if (btnp(0)) then p1.dir = p1.dir - 1 end
	if (btnp(1)) then p1.dir = p1.dir + 1 end
	
	if (p1.dir > 4) then p1.dir = 1 end
	if (p1.dir < 1) then p1.dir = 4 end
end

function draw_game()
	pset(p1.x,p1.y,12)
end

