function quests_set_SERVER(accountName) {
	var socketID = db_find_value(global.DB_SRV_TABLE_players, PLAYERS_SOCKETID_SERVER, PLAYERS_ACCID_SERVER, accountName)
	var accountInfo = db_find_row(global.DB_SRV_TABLE_accountInfo, ACCOUNTINFO_ACCID_SERVER, accountName)
	var quests = global.playerQuests[? accountName]
	
	var level = accountInfo[? ACCOUNTINFO_LEVEL_SERVER]
	
	var completedQuests = ds_list_create()
	var ds_size = ds_map_size(quests)
	var ds_keys = ds_map_keys_to_array(quests)
	for (var i = 0; i < ds_size; i++) {
		var quest = quests[? ds_keys[i]]
		
		if (quest.isCompleted)
			ds_list_add(completedQuests, quest.index)
	}
	
	var ds_size = ds_map_size(quests)
	var ds_keys = ds_map_keys_to_array(quests)
	for (var i = 0; i < ds_size; i++) {
		var quest = quests[? ds_keys[i]]
		
		if (!quest.isCompleted or quest.isRepeatable) {
			quest.isAvailable = (quest.requiredLevel == undefined or level >= quest.requiredLevel)
			
			if (quest.isAvailable) {
				var requiredQuests_met = true
				if (quest.requiredQuests != undefined and array_length(quest.requiredQuests) > 0) {
					requiredQuests_met = false
				
					var array_size = array_length(quest.requiredQuests)
					var _break_main = false
					for (var k = 0; k < array_size and !_break_main; k++) {
						var array_size_2 = array_length(quest.requiredQuests[k])
				
						var _break = false
						for (var t = 0; t < array_size_2 and !_break; t++) {
							if (ds_list_find_index(completedQuests, quest.requiredQuests[k][t]) == -1) {
								_break = true
								break
							}
							else if (t == array_size_2-1) {
								requiredQuests_met = true
								_break = true
								_break_main = true
								break
							}
						}
					}
				}
				
				if (requiredQuests_met == false)
					quest.isAvailable = false
			}
	
				
			if (quest.isAvailable and quest.isAuto)
				quest.isActive = true
		}
		else
			quest.isAvailable = false
	}
	
	ds_list_destroy(completedQuests)
}