function kick(socketID) {
	_net_event_disconnect_SERVER(,,socketID,)
	server_remove_client(socketID)
			
	net_server_send(socketID, CODE_DISCONNECT, socketID, BUFFER_TYPE_INT16)
}