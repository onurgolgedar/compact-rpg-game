function tell_active_quests_SERVER(socketID) {
	var accountName = db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID)
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

function tell_all_angles_SERVER() {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _playerRow = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		var _accountInfoRow = db_get_row_by_index(global.DB_SRV_TABLE_accountInfo, i)
		var _socketID = _playerRow[? PLAYERS_SOCKETID_SERVER]
		var _value = _playerRow[? PLAYERS_ANGLE_SERVER]
		
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_ROTATION, json_stringify({ socketID: _socketID, angle: _value }), BUFFER_TYPE_STRING, true, _accountInfoRow[? ACCOUNTINFO_LOCATION_SERVER])
	}
}

function tell_all_energies_SERVER() {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _playerRow = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		var _accountInfoRow = db_get_row_by_index(global.DB_SRV_TABLE_accountInfo, i)
		var _socketID = _playerRow[? PLAYERS_SOCKETID_SERVER]
		var _value = _playerRow[? PLAYERS_ENERGY_SERVER]
		
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_ENERGY, json_stringify({ socketID: _socketID, energy: _value }), BUFFER_TYPE_STRING, true, _accountInfoRow[? ACCOUNTINFO_LOCATION_SERVER])
	}
}

function tell_all_healths_SERVER() {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _playerRow = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		var _accountInfoRow = db_get_row_by_index(global.DB_SRV_TABLE_accountInfo, i)
		var _socketID = _playerRow[? PLAYERS_SOCKETID_SERVER]
		var _value = _playerRow[? PLAYERS_HP_SERVER]
		
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_HP, json_stringify({ socketID: _socketID, hp: _value }), BUFFER_TYPE_STRING, true, _accountInfoRow[? ACCOUNTINFO_LOCATION_SERVER])
	}
}

function tell_all_manas_SERVER() {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _playerRow = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		var _accountInfoRow = db_get_row_by_index(global.DB_SRV_TABLE_accountInfo, i)
		var _socketID = _playerRow[? PLAYERS_SOCKETID_SERVER]
		var _value = _playerRow[? PLAYERS_MANA_SERVER]
		
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_MANA, json_stringify({ socketID: _socketID, mana: _value }), BUFFER_TYPE_STRING, true, _accountInfoRow[? ACCOUNTINFO_LOCATION_SERVER])
	}
}

function tell_all_names(socketID) {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_onlineAccounts)
	for (var i = 0; i < ds_size; i++) {
		var _onlineAccountRow = db_get_row_by_index(global.DB_SRV_TABLE_onlineAccounts, i)
		var _accountInfoRow = db_get_row_by_index(global.DB_SRV_TABLE_accountInfo, i)
		var _socketID = _onlineAccountRow[? ONLINEACCOUNTS_SOCKETID_SERVER]
		var _accID = _onlineAccountRow[? ONLINEACCOUNTS_ACCID_SERVER]
		var _name = db_get_value_by_key(global.DB_SRV_TABLE_accounts, _accID, ACCOUNTS_NICKNAME_SERVER)
		
		net_server_send(socketID == undefined ? SOCKET_ID_ALL : socketID, CODE_TELL_PLAYER_NAME, json_stringify({ socketID: _socketID, name: _name }), BUFFER_TYPE_STRING, true, _accountInfoRow[? ACCOUNTINFO_LOCATION_SERVER])
	}
}

function tell_all_positions_SERVER(force) {
	force = force == undefined ? false : force
	
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _playerRow = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		var _accountInfoRow = db_get_row_by_index(global.DB_SRV_TABLE_accountInfo, i)
		
		if (_playerRow[? PLAYERS_DEATHTIMER_SERVER] == 0) {
			var _socketID = _playerRow[? PLAYERS_SOCKETID_SERVER]
			var _xx = _playerRow[? PLAYERS_X_SERVER]
			var _yy = _playerRow[? PLAYERS_Y_SERVER]
			
			var lastPosition = ds_map_find_value(global.lastPositions_sent, _socketID)
			if (lastPosition == undefined or force or (lastPosition.xx != _xx or lastPosition.yy != _yy)) {
				net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_POSITION, json_stringify({ socketID: _socketID, xx: _xx, yy: _yy }), BUFFER_TYPE_STRING, true, lastPosition == undefined or force ? 0 : _accountInfoRow[? ACCOUNTINFO_LOCATION_SERVER])
				ds_map_set(global.lastPositions_sent, _socketID, {xx: _xx, yy: _yy})
			}
		}
	}
}