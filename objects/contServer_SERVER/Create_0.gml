_db_init()
_server_init()

global.drawServer = false
global.DB_SRV_TABLE_clients = db_create_table("Clients", 7541)
db_set_column_name(global.DB_SRV_TABLE_clients, CLIENTS_SOCKETID_SERVER, "SocketID")
db_set_column_name(global.DB_SRV_TABLE_clients, CLIENTS_IP_SERVER, "IP")

_db_event_table_creation_SERVER()
_db_event_table_column_names_SERVER()