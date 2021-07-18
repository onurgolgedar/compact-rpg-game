var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
for (var i = 0; i < ds_size; i++) {
	var _row = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		
	if (_row[? PLAYERS_DEATHTIMER_SERVER] > 0) {
		_row[? PLAYERS_DEATHTIMER_SERVER] -= 1/30
		
		if (_row[? PLAYERS_DEATHTIMER_SERVER] == 0)
			spawn_player(_row[? PLAYERS_SOCKETID_SERVER])
	}
}

with (objPlayer_SERVER) {
	var _skills = ds_map_values_to_array(skills)
	var _skills_keys = ds_map_keys_to_array(skills)
	var ds_size = array_length(_skills)
	for (var j = 0; j < ds_size; j++) {
		var skill = _skills[j]
		var key = _skills_keys[j]
		net_server_send(socketID, CODE_SKILL_INFO, string(skill.index)+"|"+string(key)+"|"+string(skill.cooldownmax)+"|"+string(skill.energy)+"|"+string(skill.mana)+"|"+string(skill.code), BUFFER_TYPE_STRING, true)
	}
}

tell_all_positions_SERVER()
tell_all_healths_SERVER()
tell_all_manas_SERVER()
tell_all_energies_SERVER()
tell_all_angles_SERVER()

with(objCreature1_SERVER) {
	net_server_send(SOCKET_ID_ALL, CODE_TELL_CREATURE_POSITION, string(creatureID)+"|"+string(x)+"|"+string(y), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_CREATURE_HP, string(creatureID)+"|"+string(hp), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_CREATURE_MANA, string(creatureID)+"|"+string(mana), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_CREATURE_ENERGY, string(creatureID)+"|"+string(energy), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_CREATURE_ROTATION, string(creatureID)+"|"+string(image_angle), BUFFER_TYPE_STRING, true)
}

alarm[0] = room_speed/30