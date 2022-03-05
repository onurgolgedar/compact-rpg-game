var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
for (var i = 0; i < ds_size; i++) {
	var _row = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		
	if (_row[? PLAYERS_DEATHTIMER_SERVER] > 0) {
		_row[? PLAYERS_DEATHTIMER_SERVER] -= 1/20
		
		if (_row[? PLAYERS_DEATHTIMER_SERVER] == 0)
			player_spawn_SERVER(_row[? PLAYERS_SOCKETID_SERVER])
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
			net_server_send(socketID, CODE_SKILL_INFO, json_stringify({ index: skill.index, key: key, code: skill.code, cooldownmax: skill.cooldownmax, energy: skill.energy, mana: skill.mana, cooldown: skill.cooldown }), BUFFER_TYPE_STRING, true)
		else 
			net_server_send(socketID, CODE_SKILL_INFO, json_stringify({ index: undefined, key: key }), BUFFER_TYPE_STRING, true)
	}
}

tell_all_positions_SERVER()
tell_all_healths_SERVER()
tell_all_manas_SERVER()
tell_all_energies_SERVER()
tell_all_angles_SERVER()

with (parNPC_SERVER) {
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_POSITION, json_stringify({ npcID: npcID, xx: x, yy: y }), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_HP, json_stringify({ npcID: npcID, hp: hp }), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_MANA, json_stringify({ npcID: npcID, mana: mana }), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_ENERGY, json_stringify({ npcID: npcID, energy: energy }), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_ROTATION, json_stringify({ npcID: npcID, angle: image_angle }), BUFFER_TYPE_STRING, true)
}

alarm[0] = room_speed/30