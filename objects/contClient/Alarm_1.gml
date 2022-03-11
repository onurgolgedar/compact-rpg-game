if (global.socket_CLIENT != undefined)
	network_destroy(global.socket_CLIENT)
	
/*if (global.socket_udp_CLIENT != undefined)
	network_destroy(global.socket_udp_CLIENT)*/
	
if (global.socket_COOP != undefined)
	network_destroy(global.socket_COOP)

if (global.connectionGoal != 0 and room != roomMenu)
	room_goto(roomMenu)