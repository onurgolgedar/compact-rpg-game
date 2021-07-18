function main() {
	function_call(main, 1/20, true)
	
	if (!is_alive() or objPlayer.stunned)
		exit

	net_client_send(_CODE_PING, current_time, BUFFER_TYPE_INT32, true)

	net_client_send(_CODE_MOUSE_POSITION, string(mouse_x)+"|"+string(mouse_y), BUFFER_TYPE_STRING, true)
	
	if (device_mouse_check_button(0, mb_left) and anim_end(objPlayer) and get_active_item(ITEMTYPE_SWORD) != undefined and check_gui_to_attack())
		net_client_send(_CODE_BASIC_ATTACK, string(mouse_x)+"|"+string(mouse_y), BUFFER_TYPE_STRING, true)
	
	if (keyboard_check(vk_space) and objPlayer.skills[2].code != undefined)
		net_client_send(objPlayer.skills[2].code, round(point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y) mod 360), BUFFER_TYPE_INT16, true)
	
	if (keyboard_check(vk_shift) and objPlayer.skills[3].code != undefined)
		net_client_send(objPlayer.skills[3].code, 0, BUFFER_TYPE_BYTE, true)
}

function_call(main, 1/20, true)