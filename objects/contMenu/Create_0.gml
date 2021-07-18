//execute_shell(@'"' + working_directory + @'\\server\\New Game (Server).exe"', false)

tteIP = instance_create(50, 100, objTTEInput)
with (tteIP) {
	title = "Server"
}

tteID = instance_create(50, 310, objTTEInput)
with (tteID) {
	title = "ID"
	tte_ext_input_set_text("DefaultID")
}

ttePassword = instance_create(50, 390, objTTEInput)
with (ttePassword) {
	title = "Password"
	password = true
	tte_ext_input_set_text("123546")
}

tteName = instance_create(50, 520, objTTEInput)
with (tteName) {
	title = "Nickname"
}

tteClass = instance_create(50, 610, objTTEInput)
with (tteClass) {
	title = "Class"
}