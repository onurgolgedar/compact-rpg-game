#region FUNCTION DECLARATIONS
function client_connect(ip, port) {
	network_set_config(network_config_connect_timeout, 1000)
	
	global.socket = network_create_socket(network_socket_tcp)
	network_connect_async(global.socket, ip, port)
}
#endregion

global.socketID_player = undefined