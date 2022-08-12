counter = 0
ba_delay = 0
function main() {
	if (is_alive() and !objPlayer.stunned and global.socket_CLIENT != undefined) {
		if (counter mod 2 == 0) {
			net_client_send(_CODE_GET_EFFECTBOXES)
			net_client_send(_CODE_MOUSE_POSITION, json_stringify({ x: round(mouse_x), y: round(mouse_y) }), BUFFER_TYPE_STRING, true)
			if (global.ping_check_mode)
				net_client_send(_CODE_PING, current_time, BUFFER_TYPE_INT32, true)
		}
		
		// Input - Basic Attack
		if (ba_delay > 0)
			ba_delay -= 1/20
		if (ba_delay <= 0 and device_mouse_check_button(0, mb_left) and anim_end(objPlayer) and get_active_item(ITEMTYPE_SWORD) != undefined and check_gui_to_attack()) {
			net_client_send(_CODE_BASIC_ATTACK, json_stringify({ xx: mouse_x, yy: mouse_y }), BUFFER_TYPE_STRING, true)
			ba_delay = 0.25
		}
	
		if (!global.chatActive) {
			// Input - Skills
			if (keyboard_check(ord("1")))
				if (objPlayer.skills[0].code != undefined and objPlayer.skills[0].cooldown == 0 and objPlayer.energy >= objPlayer.skills[0].energy and objPlayer.mana >= objPlayer.skills[0].mana)
					client_send_skill_cast(objPlayer.skills[0])
		
			if (keyboard_check(ord("2")))
				if (objPlayer.skills[1].code != undefined and objPlayer.skills[1].cooldown == 0 and objPlayer.energy >= objPlayer.skills[1].energy and objPlayer.mana >= objPlayer.skills[1].mana)
					client_send_skill_cast(objPlayer.skills[1])
	
			if (keyboard_check(vk_space))
				if (objPlayer.skills[2].code != undefined and objPlayer.skills[2].cooldown == 0 and objPlayer.energy >= objPlayer.skills[2].energy and objPlayer.mana >= objPlayer.skills[2].mana)
					client_send_skill_cast(objPlayer.skills[2])
	
			if (keyboard_check(vk_shift))
				if (objPlayer.skills[3].code != undefined and objPlayer.skills[3].cooldown == 0 and objPlayer.energy >= objPlayer.skills[3].energy and objPlayer.mana >= objPlayer.skills[3].mana)
					client_send_skill_cast(objPlayer.skills[3])
		
			if (keyboard_check(vk_control))
				if (objPlayer.skills[4].code != undefined and objPlayer.skills[4].cooldown == 0 and objPlayer.energy >= objPlayer.skills[4].energy and objPlayer.mana >= objPlayer.skills[4].mana)
					client_send_skill_cast(objPlayer.skills[4])
		}
	}
	
	counter++
	
	function_call_COMMON(main, 1/15, true)
}

function_call_COMMON(main, 1/15, true)