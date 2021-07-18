function _db_event_table_creation() {
	global.DB_SRV_TABLE_clients = db_create_table("Clients", 7541)

}

function _db_event_table_column_names() {
	db_set_column_name(global.DB_SRV_TABLE_clients, CLIENTS_SOCKETID, "SocketID")
	db_set_column_name(global.DB_SRV_TABLE_clients, CLIENTS_NAME, "Name")
	db_set_column_name(global.DB_SRV_TABLE_clients, CLIENTS_IP, "IP")
}

function _db_event_table_draw() {
	db_draw_table(16, 30, global.DB_SRV_TABLE_clients, 3, "Clients")
}