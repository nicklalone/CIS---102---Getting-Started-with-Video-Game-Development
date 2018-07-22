-- can set up 2 functions and call them by update and draw.
scrn = {}
p1 = {}
p2 = {}

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
	if (btnp(4)) then run_game() end
end

function draw_menu()
	print('press z to start.',30,50,7)
end

function run_game()
	scrn.upd = update_game
	scrn.drw = draw_game
	
	p1.x = 32
	p1.y = 64
	p1.dir = 1
	
	p2.x = 96
	p2.y = 64
	p2.dir = 1
	
	cls()
	rect(0,0,127,127,1)
end

function update_player(player,player_num)
	-- right
	if (player.dir == 2) then player.x = player.x + 1 end
	-- left
	if (player.dir == 4) then player.x = player.x - 1 end
	-- up
	if (player.dir == 1) then player.y = player.y - 1 end	-- down
	if (player.dir == 3) then player.y = player.y + 1 end

	if (btnp(0, player_num)) then player.dir = player.dir - 1 end
	if (btnp(1, player_num)) then player.dir = player.dir + 1 end
	
	if (player.dir > 4) then player.dir = 1 end
	if (player.dir < 1) then player.dir = 4 end

	-- crashes go here
	
	if (pget(player.x,player.y) != 0) then show_game_over() end
end

function update_game()
	update_player(p1,0)
	update_player(p2,1)
	end

function draw_game()
	pset(p1.x,p1.y,12)
	pset(p2.x,p2.y,5)
end

function show_game_over()
	scrn.upd = update_game_over
	scrn.drw = draw_game_over
end

function update_game_over()
	if (btnp(4)) then show_menu() end
end

function draw_game_over()
	print('game over!!!',30,50,7)
end