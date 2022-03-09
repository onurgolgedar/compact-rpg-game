with (tteIP)
	global.serverIP = (tte_ext_input_get_text() == "TR" or visible == false) ? "213.254.138.50" : (tte_ext_input_get_text() == "" ? "127.0.0.1" : tte_ext_input_get_text())
	
with (tteID_signup)
	global.clientID_signup = tte_ext_input_get_text()
	
with (tteName_signup)
	global.clientName_signup = tte_ext_input_get_text()
	
with (tteCOOP_signup)
	global.coopID = tte_ext_input_get_text()
			
with (ttePassword_signup)
	global.clientPassword_signup = tte_ext_input_get_text()

var passwordRepeat = ""
with (ttePasswordRepeat_signup)
	passwordRepeat = tte_ext_input_get_text()
			
global.clientClass_signup = "Warrior"
/*with (tteClass_signup)
	global.clientClass_signup = tte_ext_input_get_text()*/
			
if (global.clientPassword_signup == passwordRepeat) {
	if (string_count(".", global.serverIP) == 3 and string_length(global.clientPassword_signup) > 0 and string_length(global.clientID_signup) > 0) {
		with (contClient) {
			// Sign up
			global.connectionGoal = 0
			alarm[0] = SEC*0.1
			alarm[1] = SEC*3
		}
	}
}
else {
	var messageBox = show_messagebox(250, 250, "Failed", "Passwords do not match.", 4)
	messageBox.depth = depth-1000
}