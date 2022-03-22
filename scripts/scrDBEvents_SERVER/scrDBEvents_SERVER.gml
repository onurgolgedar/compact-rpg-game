function _db_event_table_creation_SERVER() {
	global.DB_SRV_TABLE_players = db_create_table("Players", 1)
	global.DB_SRV_TABLE_accounts = db_load_table("Accounts", 2)
	global.DB_SRV_TABLE_accountInfo = db_load_table("AccountInfo", 3)
	global.DB_SRV_TABLE_equipments = db_load_table("Equipments", 4)
}

function _db_event_table_column_names_SERVER() {
	db_set_column_name(global.DB_SRV_TABLE_players, PLAYERS_SOCKETID_SERVER, "SocketID")
	db_set_column_name(global.DB_SRV_TABLE_players, PLAYERS_ACCID_SERVER, "AccID")
	db_set_column_name(global.DB_SRV_TABLE_players, PLAYERS_LOCATION_SERVER, "Location")
	db_set_column_name(global.DB_SRV_TABLE_players, PLAYERS_IP_SERVER, "IP")
	db_set_column_name(global.DB_SRV_TABLE_players, PLAYERS_HP_SERVER, "HP")
	db_set_column_name(global.DB_SRV_TABLE_players, PLAYERS_ENERGY_SERVER, "Energy")
	db_set_column_name(global.DB_SRV_TABLE_players, PLAYERS_X_SERVER, "X")
	db_set_column_name(global.DB_SRV_TABLE_players, PLAYERS_Y_SERVER, "Y")
	db_set_column_name(global.DB_SRV_TABLE_players, PLAYERS_ANGLE_SERVER, "Angle")
	db_set_column_name(global.DB_SRV_TABLE_players, PLAYERS_INSTANCE_SERVER, "Instance")
	db_set_column_name(global.DB_SRV_TABLE_players, PLAYERS_DEATHTIMER_SERVER, "Death Time")
	
	db_set_column_name(global.DB_SRV_TABLE_accounts, ACCOUNTS_ACCID_SERVER, "ID")
	db_set_column_name(global.DB_SRV_TABLE_accounts, ACCOUNTS_PASSWORD_SERVER, "Password")
	db_set_column_name(global.DB_SRV_TABLE_accounts, ACCOUNTS_NICKNAME_SERVER, "Nickname")
	
	db_set_column_name(global.DB_SRV_TABLE_accountInfo, ACCOUNTINFO_ACCID_SERVER, "AccountID")
	db_set_column_name(global.DB_SRV_TABLE_accountInfo, ACCOUNTINFO_GOLD_SERVER, "Gold")
	db_set_column_name(global.DB_SRV_TABLE_accountInfo, ACCOUNTINFO_LEVEL_SERVER, "Level")
	db_set_column_name(global.DB_SRV_TABLE_accountInfo, ACCOUNTINFO_LOCATION_SERVER, "Location")
}

function _db_event_table_draw_SERVER() {
	draw_set_font(fontTable_SERVER)
		db_draw_table(16, 50, global.DB_SRV_TABLE_players, 11)
		db_draw_table(16, 300, global.DB_SRV_TABLE_accountInfo, 4)
	draw_set_font(fontMain)
}