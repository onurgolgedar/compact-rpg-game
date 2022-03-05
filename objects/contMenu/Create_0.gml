//execute_shell(@'"' + working_directory + @'\\server\\New Game (Server).exe"', false)

global.connectionGoal = -1 // SIGN UP OR LOGIN

tteID = instance_create(65, 280/*550-50*/, objTTEInput)
with (tteID) {
	title = "ID"
}

ttePassword = instance_create(65, 360/*630-50*/, objTTEInput)
with (ttePassword) {
	title = "Password"
	password = true
}

tteIP = instance_create(room_width-330, room_height-90, objTTEInput)
with (tteIP) {
	visible = false
	title = "Server"
}

tteID_signup = instance_create(520+725, 280, objTTEInput)
with (tteID_signup) {
	title = "ID"
}

ttePassword_signup = instance_create(520+725, 360, objTTEInput)
with (ttePassword_signup) {
	title = "Password"
	password = true
}

ttePasswordRepeat_signup = instance_create(520+725, 440, objTTEInput)
with (ttePasswordRepeat_signup) {
	title = "Password Validation"
	password = true
}

tteName_signup = instance_create(520+725, 520, objTTEInput)
with (tteName_signup) {
	title = "Nickname"
}

/*tteClass_signup = instance_create(520+725, 520, objTTEInput)
with (tteClass_signup) {
	title = "Class"
}*/