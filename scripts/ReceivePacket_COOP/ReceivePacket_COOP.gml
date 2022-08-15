function _net_receive_packet_COOP(code, pureData, socketID_sender) {
	var data
	#region PARSE PARAMETERS
	var parameterCount = 0
	if (is_string(pureData)) {
		if (string_char_at(pureData, 0) == "{" or string_char_at(pureData, 0) == "[")
			data = json_parse(pureData)
		else {
			parameterCount = 1
			data = pureData
		}
	}
	else {
		parameterCount = 1
		data = pureData
	}
	#endregion
	
	show_debug_message("(COOP) "+string(code)+": "+string(data))

	try {
		switch(code) {						
			case CODE_CONNECT_COOP:
				if (global.socketID_COOP_player == undefined)
					global.socketID_COOP_player = data
			
				if (global.clientID == "Local" and global.coopID == "")	
					with (contClient)
						alarm[2] = SEC
				break
				
			case CODE_HOST_COOP:
				global.coopID = data
				break
		}
	}
	catch (error) {
		global.networkErrors_count++
		show_message(error)
	}
}