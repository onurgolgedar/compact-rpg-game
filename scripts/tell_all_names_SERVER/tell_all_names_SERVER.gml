/// @param socketID*
function tell_all_names(socketID) {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_onlineAccounts)
	for (var i = 0; i < ds_size; i++) {
		var _onlineAccountRow = db_get_row_by_index(global.DB_SRV_TABLE_onlineAccounts, i)
		var _socketID = _onlineAccountRow[? ONLINEACCOUNTS_SOCKETID_SERVER]
		var _accID = _onlineAccountRow[? ONLINEACCOUNTS_ACCID_SERVER]
		var _name = db_get_value_by_key(global.DB_SRV_TABLE_accounts, _accID, ACCOUNTS_NICKNAME_SERVER)
		
		net_server_send(socketID == undefined ? SOCKET_ID_ALL : socketID, CODE_TELL_PLAYER_NAME, string(_socketID)+"|"+string(_name), BUFFER_TYPE_STRING, true)
	}
}