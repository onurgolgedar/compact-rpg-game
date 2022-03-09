#region FUNCTION DECLARATIONS
function client_connect(ip, port) {
	network_set_config(network_config_connect_timeout, 3000)
	
	global.socket_CLIENT = network_create_socket(network_socket_tcp)
	network_connect(global.socket_CLIENT, ip, port)
}

function client_coop_connect(ip, port) {
	network_set_config(network_config_connect_timeout, 1000)
	
	global.socket_CLIENT_COOP = network_create_socket(network_socket_tcp)
	network_connect(global.socket_CLIENT_COOP, ip, port)
}
#endregion

global.socket_CLIENT = undefined
global.socket_COOP = undefined
global.socketID_player = undefined
global.socketID_COOP_player = undefined