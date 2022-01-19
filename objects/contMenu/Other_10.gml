with (tteIP)
	global.serverIP = tte_ext_input_get_text() == "TR" ? "213.254.138.50" : (tte_ext_input_get_text() == "" ? "127.0.0.1" : tte_ext_input_get_text())
	
with (tteID)
	global.clientID = tte_ext_input_get_text()
			
with (ttePassword)
	global.clientPassword = tte_ext_input_get_text()
			
if (string_count(".", global.serverIP) == 3 and string_length(global.clientPassword) > 0 and string_length(global.clientID) > 0) {
	room_goto_next()
	with (contClient) {
		global.connectionGoal = 1
		alarm[0] = SEC
		alarm[1] = SEC*2
	}
}