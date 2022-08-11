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
	var ds_size = array_length(skills)
	for (var i = 0; i < ds_size; i++) {
		var skill = skills[i]
		if (skill != undefined)
			net_server_send(socketID, CODE_SKILL_INFO, json_stringify({ index: skill.index, key: i, code: skill.code, cooldownmax: skill.cooldownmax, energy: skill.energy, mana: skill.mana, cooldown: skill.cooldown, upgrade: skill.upgrade }), BUFFER_TYPE_STRING, true)
		else 
			net_server_send(socketID, CODE_SKILL_INFO, json_stringify({ index: undefined, key: i }), BUFFER_TYPE_STRING, true)
	}
}

tell_all_positions_SERVER(irandom(15) == 0)
tell_all_angles_SERVER()

with (parNPC_SERVER) {
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_POSITION, json_stringify({ npcID: npcID, xx: x, yy: y }), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_ROTATION, json_stringify({ npcID: npcID, angle: image_angle }), BUFFER_TYPE_STRING, true)
}

alarm[0] = room_speed/30