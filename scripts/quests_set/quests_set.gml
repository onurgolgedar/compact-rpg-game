function quests_set(accountName) {
	var socketID = db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_SOCKETID_SERVER, ONLINEACCOUNTS_ACCID_SERVER, accountName)
	var accountInfo = db_find_row(global.DB_SRV_TABLE_accountInfo, ACCOUNTINFO_ACCID_SERVER, accountName)
	var quests = global.playerQuests[? accountName]
	
	var level = accountInfo[? ACCOUNTINFO_LEVEL_SERVER]
	
	var completedQuests = ds_list_create()
	var ds_size = ds_map_size(quests)
	for (var i = 0; i < ds_size; i++) {
		var quest = quests[? i]
		
		if (quest.isCompleted)
			ds_list_add(completedQuests, quest.index)
	}
	
	var ds_size = ds_map_size(quests)
	for (var i = 0; i < ds_size ; i++) {
		var quest = quests[? i]
		
		if (!quest.isCompleted or quest.isRepeatable) {
			quest.isAvailable = (quest.requiredLevel == undefined or level >= quest.requiredLevel)
				
			var array_size = array_length(quest.requiredQuests)
			var _break = false
			for (var k = 0; k < array_size and !_break; k++) {
				var array_size_2 = array_length(quest.requiredQuests[k])
				for (var t = 0; t < array_size_2; t++) {
					if (ds_list_find_index(completedQuests, quest.requiredQuests[k][t]) == -1)
						quest.isAvailable = false
						_break = true
						break
				}
			}
		}
		else
			quest.isAvailable = false
	}
	
	ds_list_destroy(completedQuests)
}