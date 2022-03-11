#region FUNCTION DECLARATIONS
function client_connect(ip, port) {
	if (global.socket_CLIENT != undefined)
		network_destroy(global.socket_CLIENT)
		
	/*if (global.socket_udp_CLIENT != undefined)
		network_destroy(global.socket_udp_CLIENT)*/
	
	network_set_config(network_config_connect_timeout, 3000)
	
	global.socket_CLIENT = network_create_socket(network_socket_tcp)
	network_connect(global.socket_CLIENT, ip, port)
	
	/*global.socket_udp_CLIENT = network_create_socket(network_socket_udp)
	network_connect(global.socket_udp_CLIENT, ip, port+1)*/
}

function client_coop_connect(ip, port) {
	if (global.socket_COOP != undefined)
		network_destroy(global.socket_COOP)
	
	network_set_config(network_config_connect_timeout, 1000)
	
	global.socket_COOP = network_create_socket(network_socket_tcp)
	network_connect(global.socket_COOP, ip, port)
}
#endregion

event_user(0)