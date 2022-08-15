if (global.socket_CLIENT != undefined)
	network_destroy(global.socket_CLIENT)
global.socket_CLIENT = undefined
	
/*if (global.socket_udp_CLIENT != undefined)
	network_destroy(global.socket_udp_CLIENT)*/
	
if (global.socket_COOP != undefined)
	network_destroy(global.socket_COOP)
global.socket_COOP = undefined