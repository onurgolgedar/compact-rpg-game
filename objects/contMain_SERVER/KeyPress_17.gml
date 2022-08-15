var player = instance_nearest(mouse_x, mouse_y, objPlayer_SERVER)
global.selectedPlayer_SERVER = player
if (global.selectedPlayer_SERVER == noone)
	global.selectedPlayer_SERVER = undefined