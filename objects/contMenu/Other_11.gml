
with (tteIP)
	global.serverIP = tte_ext_input_get_text() == "TR" ? "213.254.138.50" : (tte_ext_input_get_text() == "" ? "127.0.0.1" : tte_ext_input_get_text())
	
with (tteID_signup)
	global.clientID_signup = tte_ext_input_get_text()
	
with (tteName_signup)
	global.clientName_signup = tte_ext_input_get_text()
			
with (ttePassword_signup)
	global.clientPassword_signup = tte_ext_input_get_text()
			
with (tteClass_signup)
	global.clientClass_signup = tte_ext_input_get_text()
			
if (string_count(".", global.serverIP) == 3 and string_length(global.clientPassword_signup) > 0 and string_length(global.clientID_signup) > 0) {
	with (contClient) {
		global.connectionGoal = 0
		alarm[0] = SEC
		alarm[1] = SEC*2
	}
}