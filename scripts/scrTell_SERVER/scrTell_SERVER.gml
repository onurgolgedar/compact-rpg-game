function tell_active_quests_SERVER(socketID) {
	var accountName = db_find_value(global.DB_SRV_TABLE_players, PLAYERS_ACCID_SERVER, PLAYERS_SOCKETID_SERVER, socketID)
	var quests = global.playerQuests_SERVER[? accountName]
	
	var activeQuests = ds_map_create()
	var ds_size = ds_map_size(quests)
	var ds_keys = ds_map_keys_to_array(quests)
	for (var i = 0; i < ds_size; i++) {
		var quest = quests[? ds_keys[i]]

		if (quest.isActive)
			ds_map_add(activeQuests, quest.code, json_stringify(quest))
	}
	
	net_server_send(socketID, CODE_GET_ACTIVE_QUESTS, ds_map_write(activeQuests), BUFFER_TYPE_STRING)
}

function tell_appearence_SERVER(socketID, socketID_receiver) {
	var box = box_get_active_SERVER(socketID, ITEMTYPE_SWORD)
	var weaponSprite = box.item == undefined ? sprite_get_name(sprNothingness) : sprite_get_name(box.item.sprite)
	
	box = box_get_active_SERVER(socketID, ITEMTYPE_CLOTHES)
	var clothesSprite = box.item == undefined ? sprite_get_name(sprNothingness) : sprite_get_name(box.item.sprite)
	
	net_server_send(socketID_receiver, CODE_APPEARENCE, json_stringify({ socketID: socketID, weapon: weaponSprite, shoulders: clothesSprite }), BUFFER_TYPE_STRING)
}

function tell_all_pl_energies_SERVER(target = objPlayer_SERVER) {
	with (target)
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_ENERGY, round(energy), BUFFER_TYPE_INT32, true, location, socketID)
}

function tell_all_pl_healths_SERVER(target = objPlayer_SERVER) {
	with (target)
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_HP, round(hp), BUFFER_TYPE_INT32, true, location, socketID)
}

function tell_all_pl_manas_SERVER(target = objPlayer_SERVER) {
	with (target)
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_MANA, round(mana), BUFFER_TYPE_INT32, true, location, socketID)
}

function tell_all_npc_energies_SERVER(target = objPlayer_SERVER) {
	with (target)
		net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_ENERGY, round(energy), BUFFER_TYPE_INT32, true, location, npcID)
}

function tell_all_npc_healths_SERVER(target = objPlayer_SERVER) {
	with (target)
		net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_HP, round(hp), BUFFER_TYPE_INT32, true, location, npcID)
}

function tell_all_npc_manas_SERVER(target = objPlayer_SERVER) {
	with (target)
		net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_MANA, round(mana), BUFFER_TYPE_INT32, true, location, npcID)
}

function tell_all_names(target = objPlayer_SERVER, socketID = SOCKET_ID_ALL, force = false) {
	with (target) {
		var _accID = playerRow[? PLAYERS_ACCID_SERVER]
		var _name = db_find_value(global.DB_SRV_TABLE_accounts, ACCOUNTS_NICKNAME_SERVER, ACCOUNTS_ACCID_SERVER, _accID)

		net_server_send(socketID, CODE_TELL_PLAYER_NAME, _name, BUFFER_TYPE_STRING, true, force ? 0 : location, id.socketID)
	}
}

function tell_all_pl_angles_SERVER(target = objPlayer_SERVER, force = false) {
	with (target) {
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_ROTATION, round(image_angle), BUFFER_TYPE_INT32, true, force ? 0 : location, socketID)
	}
}

function tell_all_pl_positions_SERVER(target = objPlayer_SERVER, force = false) {
	with (target) {
		var loc = round(x)*100000+round(y)

		if (lastPosition == undefined or force or lastPosition != loc) {
			net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_POSITION, string(loc), BUFFER_TYPE_STRING, true, lastPosition == undefined or force ? 0 : location, socketID)
			lastPosition = loc
		}
	}
}

function tell_all_npc_positions_SERVER(target = parNPC_SERVER, force = false) {
	with (target) {
		var loc = round(x)*100000+round(y)
		
		if (lastPosition == undefined or force or lastPosition != loc) {
			net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_POSITION, string(loc), BUFFER_TYPE_STRING, true, lastPosition == undefined or force ? 0 : location, npcID)
			lastPosition = loc
		}
	}
}

function tell_all_npc_angles_SERVER(target = parNPC_SERVER, force = false) {
	with (target)
		net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_ROTATION, round(image_angle), BUFFER_TYPE_INT32, true, force ? 0 : location, npcID)
}