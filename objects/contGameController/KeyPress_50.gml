if (!is_alive() or objPlayer.stunned)
	exit
	
if (objPlayer.skills[1].code != undefined)
	net_client_send(objPlayer.skills[1].code, round(point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y) mod 360), BUFFER_TYPE_INT16)