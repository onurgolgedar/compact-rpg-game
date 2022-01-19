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
				net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_POSITION, string(_socketID)+"|"+string(_xx)+"|"+string(_yy), BUFFER_TYPE_STRING, true, _accountInfoRow[? ACCOUNTINFO_LOCATION_SERVER])
				ds_map_set(global.lastPositions_sent, _socketID, {xx: _xx, yy: _yy})
			}
		}
	}
}