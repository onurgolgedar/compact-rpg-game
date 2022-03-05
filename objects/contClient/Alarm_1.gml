if (global.socket != undefined)
	network_destroy(global.socket)

if (global.connectionGoal != 0 and room != roomMenu)
	room_goto(roomMenu)