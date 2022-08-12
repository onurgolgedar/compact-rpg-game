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

global.ping = 0
global.ping_check_mode = false
global.networkErrors_count = 0

ini_open("config.ini")
	global.ping_check_mode = ini_read_real("NETWORK", "check_ping_mode", 0)
ini_close()

event_user(0)