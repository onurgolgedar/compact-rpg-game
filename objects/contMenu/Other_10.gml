with (tteIP)
	global.serverIP = (tte_ext_input_get_text() == "TR" or visible == false) ? "213.254.138.50" : (tte_ext_input_get_text() == "" ? "127.0.0.1" : tte_ext_input_get_text())
	
with (tteIP_COOP)
	global.coopIP = (tte_ext_input_get_text() == "TR" or visible == false) ? "213.254.138.50" : (tte_ext_input_get_text() == "" ? "127.0.0.1" : tte_ext_input_get_text())
	
with (tteID)
	global.clientID = tte_ext_input_get_text()
	
with (tteCOOP)
	global.coopID = tte_ext_input_get_text()
			
with (ttePassword)
	global.clientPassword = tte_ext_input_get_text()

// Quick Start (Always Local)
if (global.connectionGoal == 3) {
	global.clientID = ""
	global.clientPassword = ""

	if (global.clientID == "") {
		global.clientID = "Local"
		global.serverIP = "127.0.0.1"
		global.coopIP = "127.0.0.1"
	}
	
	if (global.clientPassword == "")
		global.clientPassword = "123546"
}

// Login with COOP ID
if (global.connectionGoal == 1 and global.coopID != "") {
	global.mainTCP_port = PORT_TCP_COOP
	global.mainUDP_port = PORT_UDP_COOP
	global.serverIP = global.coopIP
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