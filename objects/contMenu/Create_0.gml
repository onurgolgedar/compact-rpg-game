//execute_shell(@'"' + working_directory + @'\\server\\New Game (Server).exe"', false)

global.connectionGoal = 0 // SIGN UP OR LOGIN

tteIP = instance_create(room_width-330, room_height-90, objTTEInput)
with (tteIP) {
	title = "Server"
}

tteID = instance_create(70, 350, objTTEInput)
with (tteID) {
	title = "ID"
	tte_ext_input_set_text("DefaultID")
}

ttePassword = instance_create(70, 430, objTTEInput)
with (ttePassword) {
	title = "Password"
	password = true
	tte_ext_input_set_text("123546")
}

tteID_signup = instance_create(520, 280, objTTEInput)
with (tteID_signup) {
	title = "ID"
	tte_ext_input_set_text("DefaultID")
}

ttePassword_signup = instance_create(520, 360, objTTEInput)
with (ttePassword_signup) {
	title = "Password"
	password = true
	tte_ext_input_set_text("123546")
}

tteName_signup = instance_create(520, 440, objTTEInput)
with (tteName_signup) {
	title = "Nickname"
}

tteClass_signup = instance_create(520, 520, objTTEInput)
with (tteClass_signup) {
	title = "Class"
}