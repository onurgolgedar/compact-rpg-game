if (async_load[? "port"] == global.mainTCP_port or async_load[? "port"] == global.mainUDP_port) {
	load_buffer = async_load[? "buffer"]
	load_id = async_load[? "id"]
	load_type = async_load[? "type"]
	load_socketID = async_load[? "socket"]
	load_ip = async_load[? "ip"]
	
	switch(load_type)
	{		
		case network_type_data:
			var data = net_buffer_read(load_buffer)
			if (data != undefined)
				_net_receive_packet(data[0], data[1], load_id, data[2], net_buffer_get_type_reverse(data[3]))
			break
		
		case network_type_connect:
			_net_event_connect(load_buffer, load_id, load_socketID, load_ip)
			break
		
		case network_type_disconnect:
			_net_event_disconnect(load_buffer, load_id, load_socketID, load_ip)
			break
		
		case network_type_non_blocking_connect:		
			_net_event_non_blocking_connect(load_buffer, load_id, load_socketID, load_ip)
			break
	}
}
else if (async_load[? "port"] == PORT_TCP_COOP or async_load[? "port"] == PORT_UDP_COOP) {
	load_buffer = async_load[? "buffer"]
	load_id = async_load[? "id"]
	load_type = async_load[? "type"]
	load_socketID = async_load[? "socket"]
	load_ip = async_load[? "ip"]
	
	switch(load_type)
	{		
		case network_type_data:
			var data = net_buffer_read(load_buffer)
			if (data != undefined)
				_net_receive_packet_COOP(data[0], data[1], load_id)
			break
		
		case network_type_connect:
			break
		
		case network_type_disconnect:
			break
		
		case network_type_non_blocking_connect:		
			break
	}
}