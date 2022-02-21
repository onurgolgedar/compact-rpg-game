var done = false
if (!is_click_blocked() and global.held_box != undefined) {
	if (global.held_from_assetName == object_get_name(objSkills_window) and mouseOnSkillBox != undefined) {
		net_client_send(_CODE_SET_SKILLBOX, string(mouseOnSkillBox)+"|"+string(global.held_box.skill.index)+"|-1", BUFFER_TYPE_STRING)
		done = true
	}
	else if (global.held_from_assetName == object_get_name(contDrawGUI) and mouseOnSkillBox != undefined) {
		net_client_send(_CODE_SET_SKILLBOX, string(mouseOnSkillBox)+"|"+string(global.held_box.index)+"|"+string(global.held_box_i), BUFFER_TYPE_STRING)
		done = true
	}
}

if (!done)
	alarm[0] = 1

alarm[1] = 2