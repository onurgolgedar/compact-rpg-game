function tell_active_quests_SERVER(socketID) {
	var accountName = db_find_value(global.DB_SRV_TABLE_players, PLAYERS_ACCID_SERVER, PLAYERS_SOCKETID_SERVER, socketID)
	var quests = global.playerQuests[? accountName]
	
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

function tell_all_energies_SERVER() {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _playerRow = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_ENERGY, json_stringify({ socketID: _playerRow[? PLAYERS_SOCKETID_SERVER], energy: _playerRow[? PLAYERS_ENERGY_SERVER] }), BUFFER_TYPE_STRING, true, _playerRow[? PLAYERS_LOCATION_SERVER])
	}
}

function tell_all_healths_SERVER() {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _playerRow = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_HP, json_stringify({ socketID: _playerRow[? PLAYERS_SOCKETID_SERVER], hp: _playerRow[? PLAYERS_HP_SERVER] }), BUFFER_TYPE_STRING, true, _playerRow[? PLAYERS_LOCATION_SERVER])
	}
}

function tell_all_manas_SERVER() {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _playerRow = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_MANA, json_stringify({ socketID: _playerRow[? PLAYERS_SOCKETID_SERVER], mana: _playerRow[? PLAYERS_MANA_SERVER] }), BUFFER_TYPE_STRING, true, _playerRow[? PLAYERS_LOCATION_SERVER])
	}
}

function tell_all_names(socketID, force = false) {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _playerRow = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		var _accID = _playerRow[? PLAYERS_ACCID_SERVER]
		var _name = db_find_value(global.DB_SRV_TABLE_accounts, ACCOUNTS_NICKNAME_SERVER, ACCOUNTS_ACCID_SERVER, _accID)

		net_server_send(socketID == undefined ? SOCKET_ID_ALL : socketID, CODE_TELL_PLAYER_NAME, json_stringify({ socketID: _playerRow[? PLAYERS_SOCKETID_SERVER], name: _name }), BUFFER_TYPE_STRING, true, force ? 0 : _playerRow[? PLAYERS_LOCATION_SERVER])
	}
}

function tell_all_angles_SERVER() {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _playerRow = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		var _socketID = _playerRow[? PLAYERS_SOCKETID_SERVER] 
	    var _location = db_find_value(global.DB_SRV_TABLE_players, PLAYERS_LOCATION_SERVER, PLAYERS_SOCKETID_SERVER, _socketID)
		
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_ROTATION, json_stringify({ socketID: _socketID, angle: _playerRow[? PLAYERS_ANGLE_SERVER] }), BUFFER_TYPE_STRING, true, _location)
	}
}

function tell_all_positions_SERVER(force = false) {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _playerRow = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		
		if (_playerRow[? PLAYERS_DEATHTIMER_SERVER] == 0) {
			var _socketID = _playerRow[? PLAYERS_SOCKETID_SERVER]
			var _location = _playerRow[? PLAYERS_LOCATION_SERVER]
			
			var _xx = _playerRow[? PLAYERS_X_SERVER]
			var _yy = _playerRow[? PLAYERS_Y_SERVER]
			
			var lastPosition = ds_map_find_value(global.lastPositions_sent, _socketID)
			if (lastPosition == undefined or force or (lastPosition.xx != _xx or lastPosition.yy != _yy)) {
				net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_POSITION, json_stringify({ socketID: _socketID, xx: _xx, yy: _yy }), BUFFER_TYPE_STRING, true, lastPosition == undefined or force ? 0 : _location)
				ds_map_set(global.lastPositions_sent, _socketID, {xx: _xx, yy: _yy})
			}
		}
	}
}