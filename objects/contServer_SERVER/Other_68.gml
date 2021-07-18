if (async_load[? "port"] == PORT_TCP) {
	load_buffer = async_load[? "buffer"]
	load_id = async_load[? "id"]
	load_type = async_load[? "type"]
	load_socketID = async_load[? "socket"]
	load_ip = async_load[? "ip"]
	
	switch(load_type)
	{		
		case network_type_data:
			break
		
		case network_type_connect:
			server_add_client(load_socketID)
			server_edit_client(load_socketID, CLIENTS_IP_SERVER, load_ip)
			_net_event_connect_SERVER(load_buffer, load_id, load_socketID, load_ip)

			net_server_send(load_socketID, CODE_CONNECT, load_socketID, BUFFER_TYPE_INT16)
			break
		
		case network_type_disconnect:
			_net_event_disconnect_SERVER(load_buffer, load_id, load_socketID, load_ip)
			server_remove_client(load_socketID)
			
			net_server_send(load_socketID, CODE_DISCONNECT, load_socketID, BUFFER_TYPE_INT16)
			break
		
		case network_type_non_blocking_connect:
			_net_event_non_blocking_connect_SERVER(load_buffer, load_id, load_socketID, load_ip)
			break
	}
}

