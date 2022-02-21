var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
for (var i = 0; i < ds_size; i++) {
	var _row = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		
	if (_row[? PLAYERS_DEATHTIMER_SERVER] > 0) {
		_row[? PLAYERS_DEATHTIMER_SERVER] -= 1/20
		
		if (_row[? PLAYERS_DEATHTIMER_SERVER] == 0)
			spawn_player_SERVER(_row[? PLAYERS_SOCKETID_SERVER])
	}
}

with (objPlayer_SERVER) {
	var _skills = ds_map_values_to_array(skills)
	var _skills_keys = ds_map_keys_to_array(skills)
	var ds_size = array_length(_skills)
	for (var j = 0; j < ds_size; j++) {
		var skill = _skills[j]
		var key = _skills_keys[j]
		if (skill != undefined)
			net_server_send(socketID, CODE_SKILL_INFO, string(skill.index)+"|"+string(key)+"|"+string(skill.cooldownmax)+"|"+string(skill.energy)+"|"+
													   string(skill.mana)+"|"+string(skill.code)+"|"+string(skill.cooldown), BUFFER_TYPE_STRING, true)
		else 
			net_server_send(socketID, CODE_SKILL_INFO, "undefined|"+string(key), BUFFER_TYPE_STRING, true)
	}
}

tell_all_positions_SERVER()
tell_all_healths_SERVER()
tell_all_manas_SERVER()
tell_all_energies_SERVER()
tell_all_angles_SERVER()

with (objCreature1_SERVER) {
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_POSITION, string(npcID)+"|"+string(x)+"|"+string(y), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_HP, string(npcID)+"|"+string(hp), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_MANA, string(npcID)+"|"+string(mana), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_ENERGY, string(npcID)+"|"+string(energy), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_ROTATION, string(npcID)+"|"+string(image_angle), BUFFER_TYPE_STRING, true)
}

with (objNPC_SERVER) {
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_POSITION, string(npcID)+"|"+string(x)+"|"+string(y), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_HP, string(npcID)+"|"+string(hp), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_MANA, string(npcID)+"|"+string(mana), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_ENERGY, string(npcID)+"|"+string(energy), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_ROTATION, string(npcID)+"|"+string(image_angle), BUFFER_TYPE_STRING, true)
}

alarm[0] = room_speed/30