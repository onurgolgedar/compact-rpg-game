function main() {
	// Data Transfer
	net_client_send(_CODE_PING, current_time, BUFFER_TYPE_INT32, true)
	net_client_send(_CODE_MOUSE_POSITION, json_stringify({ xx: mouse_x, yy: mouse_y }), BUFFER_TYPE_STRING, true)
	
	if (is_alive() and !objPlayer.stunned) {
		// Input - Basic Attack
		if (device_mouse_check_button(0, mb_left) and anim_end(objPlayer) and get_active_item(ITEMTYPE_SWORD) != undefined and check_gui_to_attack())
			net_client_send(_CODE_BASIC_ATTACK, json_stringify({ xx: mouse_x, yy: mouse_y }), BUFFER_TYPE_STRING, true)
	
		// Input - Skills
		if (keyboard_check(ord("1")))
			if (objPlayer.skills[0].code != undefined and objPlayer.skills[0].cooldown == 0 and objPlayer.energy >= objPlayer.skills[0].energy and objPlayer.mana >= objPlayer.skills[0].mana)
				client_send_skill_cast(objPlayer.skills[0].code, objPlayer.skills[0].index)
		
		if (keyboard_check(ord("2")))
			if (objPlayer.skills[1].code != undefined and objPlayer.skills[1].cooldown == 0 and objPlayer.energy >= objPlayer.skills[1].energy and objPlayer.mana >= objPlayer.skills[1].mana)
				client_send_skill_cast(objPlayer.skills[1].code, objPlayer.skills[1].index)
	
		if (keyboard_check(vk_space))
			if (objPlayer.skills[2].code != undefined and objPlayer.skills[2].cooldown == 0 and objPlayer.energy >= objPlayer.skills[2].energy and objPlayer.mana >= objPlayer.skills[2].mana)
				client_send_skill_cast(objPlayer.skills[2].code, objPlayer.skills[2].index)
	
		if (keyboard_check(vk_shift))
			if (objPlayer.skills[3].code != undefined and objPlayer.skills[3].cooldown == 0 and objPlayer.energy >= objPlayer.skills[3].energy and objPlayer.mana >= objPlayer.skills[3].mana)
				client_send_skill_cast(objPlayer.skills[3].code, objPlayer.skills[3].index)
		
		if (keyboard_check(vk_control))
			if (objPlayer.skills[4].code != undefined and objPlayer.skills[4].cooldown == 0 and objPlayer.energy >= objPlayer.skills[4].energy and objPlayer.mana >= objPlayer.skills[4].mana)
				client_send_skill_cast(objPlayer.skills[4].code, objPlayer.skills[4].index)
	}
		
	function_call(main, 1/20, true)
}

function_call(main, 1/20, true)