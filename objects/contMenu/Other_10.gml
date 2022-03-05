with (tteIP)
	global.serverIP = (tte_ext_input_get_text() == "TR" or visible == false) ? "213.254.138.50" : (tte_ext_input_get_text() == "" ? "127.0.0.1" : tte_ext_input_get_text())
	
with (tteID)
	global.clientID = tte_ext_input_get_text()
			
with (ttePassword)
	global.clientPassword = tte_ext_input_get_text()

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
			
if (string_count(".", global.serverIP) == 3 and string_length(global.clientPassword) > 0 and string_length(global.clientID) > 0) {
	room_goto_next()
	with (contClient) {
		global.connectionGoal = 1
		alarm[0] = SEC*0.1
		alarm[1] = SEC*3
	}
}