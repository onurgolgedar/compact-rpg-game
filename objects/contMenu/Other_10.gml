ini_open("config.ini")
	with (contClient)
		event_user(0)

	with (tteIP)
		global.serverIP = ini_read_string("SERVER", tte_ext_input_get_text(), "127.0.0.1")
	
	with (tteIP_COOP)
		global.coopIP = ini_read_string("COOP", tte_ext_input_get_text(), "127.0.0.1")
	
	with (tteID)
		global.clientID = tte_ext_input_get_text()
	
	with (tteCOOP)
		global.coopID = tte_ext_input_get_text()
			
	with (ttePassword)
		global.clientPassword = tte_ext_input_get_text()
ini_close()

// Quick Start (Always Local)
if (global.connectionGoal == 3) {
	global.clientID = ""
	global.clientPassword = ""

	if (global.clientID == "") {
		global.clientID = "Local"
		global.serverIP = "127.0.0.1"
	}
	
	if (global.clientPassword == "")
		global.clientPassword = "123546"
}

if (global.connectionGoal == 1 and global.coopID != "") {
	global.mainTCP_port = PORT_TCP_COOP
	global.mainUDP_port = PORT_UDP_COOP
	global.serverIP = global.coopIP
}
else {
	global.mainTCP_port = PORT_TCP
	global.mainUDP_port = PORT_UDP
}
			
if (string_count(".", global.serverIP) == 3 and string_length(global.clientPassword) > 0 and string_length(global.clientID) > 0) {
	room_goto_next()
	with (contClient) {
		// Login
		global.connectionGoal = 1
		alarm[0] = SEC*0.1
		alarm[1] = SEC*3
	}
}