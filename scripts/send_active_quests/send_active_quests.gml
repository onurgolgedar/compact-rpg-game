function send_active_quests(socketID) {
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