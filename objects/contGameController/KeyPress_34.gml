var accountID = db_get_value_by_key(global.DB_SRV_TABLE_onlineAccounts, global.socketID_player, ONLINEACCOUNTS_ACCID_SERVER)
net_client_send(_CODE_LOCATION, 2, BUFFER_TYPE_BYTE)