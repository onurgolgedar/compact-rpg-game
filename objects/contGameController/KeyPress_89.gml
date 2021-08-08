if (is_alive()) {
	if (!instance_exists(objSkills_window)) {
		instance_create_layer(contDrawGUI.guiWidth-400, 140, "Windows", objSkills_window)
		net_client_send(_CODE_GET_BOXES_SKILL)
	}
	else
		instance_destroy(objSkills_window)
}
else
	instance_destroy(objSkills_window)