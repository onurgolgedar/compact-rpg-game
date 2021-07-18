var player = instance_nearest(mouse_x, mouse_y, objPlayer_SERVER)
global.selectedPlayer = player
if (global.selectedPlayer == noone)
	global.selectedPlayer = undefined