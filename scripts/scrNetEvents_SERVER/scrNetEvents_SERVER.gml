function _net_event_connect_SERVER(load_buffer, load_id, load_socketID, load_ip) {
}

function _net_event_disconnect_SERVER(load_buffer, load_id, load_socketID, load_ip) {
	var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, load_socketID, PLAYERS_INSTANCE_SERVER)
	if (instance != undefined)
		instance_destroy(instance)
	
	db_delete_row(global.DB_SRV_TABLE_players, load_socketID)
	
	net_server_send(SOCKET_ID_ALL, CODE_DISCONNECT, load_socketID, BUFFER_TYPE_INT16)
}

function _net_event_non_blocking_connect_SERVER(load_buffer, load_id, load_socketID, load_ip) {

}