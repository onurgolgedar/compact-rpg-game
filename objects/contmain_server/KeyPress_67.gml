if (keyboard_check(vk_control)) {
	var creature = instance_create_layer(mouse_x, mouse_y, "Normal", objCreature1_SERVER)

	with (creature) {
		net_server_send(SOCKET_ID_ALL, CODE_SPAWN_NPC, json_stringify({ npcID: real(id).targetID, xx: round(x), yy: round(y), maxHp: maxHp, maxEnergy: maxEnergy, maxMana: maxMana, name: name, clientObject: object_get_name(clientObject) }), BUFFER_TYPE_STRING)
		location = db_get_value_by_key(global.DB_SRV_TABLE_players, global.socketID_player, PLAYERS_LOCATION_SERVER)
	}
}