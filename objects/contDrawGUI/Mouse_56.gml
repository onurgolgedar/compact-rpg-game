var done = false
if (!is_click_blocked() and global.held_box != undefined) {
	if (global.held_from_assetName == object_get_name(objSkills_window) and mouseOnSkillBox != undefined) {
		net_client_send(_CODE_SET_SKILLBOX, json_stringify({ index: global.held_box.skill.index, to: mouseOnSkillBox, from: -1 }), BUFFER_TYPE_STRING)
		done = true
	}
	else if (global.held_from_assetName == object_get_name(contDrawGUi) and mouseOnSkillBox != undefined) {
		net_client_send(_CODE_SET_SKILLBOX, json_stringify({ index: global.held_box.index, to: mouseOnSkillBox, from: global.held_box_i }), BUFFER_TYPE_STRING)
		done = true
	}
}

if (!done)
	alarm[0] = 1
	
alarm[1] = 2