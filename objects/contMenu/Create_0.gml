//execute_shell(@'"' + working_directory + @'\\server\\New Game (Server).exe"', false)

global.connectionGoal = -1 // SIGN UP OR LOGIN
global.publicGame = true
global.mainTCP_port = PORT_TCP
global.mainUDP_port = PORT_UDP
global.coopID = ""
global.clientID = ""

tteID = instance_create(65, 200, objTTEInput)
with (tteID) {
	title = "ID"
}

ttePassword = instance_create(65, 280, objTTEInput)
with (ttePassword) {
	title = "Password"
	password = true
}

tteCOOP = instance_create(65, 360, objTTEInput)
with (tteCOOP) {
	title = "Coop ID (optional)"
}

tteIP = instance_create(room_width-330, room_height-90, objTTEInput)
with (tteIP) {
	visible = false
	title = "Server"
	tte_ext_input_set_text("TR")
}

tteIP_COOP = instance_create(room_width-330, room_height-170, objTTEInput)
with (tteIP_COOP) {
	visible = false
	title = "Co-op Server"
	tte_ext_input_set_text("TR")
}

tteID_signup = instance_create(1245, 200, objTTEInput)
with (tteID_signup) {
	title = "ID"
}

ttePassword_signup = instance_create(1245, 280, objTTEInput)
with (ttePassword_signup) {
	title = "Password"
	password = true
}

ttePasswordRepeat_signup = instance_create(1245, 360, objTTEInput)
with (ttePasswordRepeat_signup) {
	title = "Password Validation"
	password = true
}

tteName_signup = instance_create(1245, 440, objTTEInput)
with (tteName_signup) {
	title = "Nickname"
}

tteCOOP_signup = instance_create(1245, 520, objTTEInput)
with (tteCOOP_signup) {
	title = "Coop ID (optional)"
}

/*tteClass_signup = instance_create(1245, 580, objTTEInput)
with (tteClass_signup) {
	title = "Class"
}*/