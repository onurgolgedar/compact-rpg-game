function tell_all_manas_SERVER() {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _playerRow = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		var _accountInfoRow = db_get_row_by_index(global.DB_SRV_TABLE_accountInfo, i)
		var _socketID = _playerRow[? PLAYERS_SOCKETID_SERVER]
		var _value = _playerRow[? PLAYERS_MANA_SERVER]
		
		net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_MANA, string(_socketID)+"|"+string(_value), BUFFER_TYPE_STRING, true, _accountInfoRow[? ACCOUNTINFO_LOCATION_SERVER])
	}
}
