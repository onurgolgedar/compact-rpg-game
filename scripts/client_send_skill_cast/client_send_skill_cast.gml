function client_send_skill_cast(skill) {
	switch(skill.index) {
		case SKILL_0:
			net_client_send(skill.code)
			break
		
		case SKILL_1:
			net_client_send(skill.code, round(point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y) mod 360), BUFFER_TYPE_INT16)
			break
		
		case SKILL_2:
			net_client_send(skill.code, round(point_direction(objPlayer.x, objPlayer.y, mouse_x, mouse_y) mod 360), BUFFER_TYPE_INT16, true)
			break
		
		case SKILL_3:
			net_client_send(skill.code, 0, BUFFER_TYPE_BYTE, true)
			break
	}
}