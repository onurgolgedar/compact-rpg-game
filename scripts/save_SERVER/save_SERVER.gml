function save_SERVER(socketID) {
	var saveStarted = false
	
	// ? Optimization
	if (socketID == undefined)
		db_save_table(global.DB_SRV_TABLE_accounts)
	
	// ? Just need to save the socketID's accountInfo if any socketID is written.
	db_save_table(global.DB_SRV_TABLE_accountinfo)

	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _row = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		var accountID = _row[? PLAYERS_ACCID_SERVER]
		var _socketID = _row[? PLAYERS_SOCKETID_SERVER]
		if (socketID != undefined) {
			if (_socketID != socketID)
				continue
			else
				saveStarted = true
		}
		else
			saveStarted = true
	
		// Save - Inventory
		var boxes_SERVER = global.playerBoxes_SERVER[? accountID]
		var _grid_items = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
		for (var k = 0; k < global.bc_hor_COMMON*global.pageCount_COMMON; k++) {
			for (var d = 0; d < global.bc_ver_COMMON+2; d++)
				ds_grid_set(_grid_items, k, d, json_stringify(ds_grid_get(boxes_SERVER, k, d)))
		}
	
		// Save - Skill Tree
		var boxes_skill_SERVER = global.playerSkills_SERVER[? accountID]
		var _grid_skills = ds_grid_create(global.sc_hor_COMMON*global.pageCount_skill_COMMON, global.sc_ver_COMMON)
		for (var k = 0; k < global.sc_hor_COMMON*global.pageCount_skill_COMMON; k++) {
			for (var d = 0; d < global.sc_ver_COMMON; d++)
				ds_grid_set(_grid_skills, k, d, json_stringify(ds_grid_get(boxes_skill_SERVER, k, d)))
		}
	
		// Save - Quests
		var quests_SERVER = global.playerQuests_SERVER[? accountID]
		var _map_quests = ds_map_create()
		var _quests_keys = ds_map_keys_to_array(quests_SERVER)
		var ds_size2 = array_length(_quests_keys)
		for (var k = 0; k < ds_size2; k++) {
			var key = _quests_keys[k]
			ds_map_add(_map_quests, key, json_stringify(quests_SERVER[? key]))
		}
		
		// Save - Skill Boxes
		var skillBoxes_SERVER = global.playerSkillBoxes_SERVER[? accountID]
		var _map_skillBoxes = ds_map_create()
		var _skillBoxes_keys = ds_map_keys_to_array(skillBoxes_SERVER)
		var ds_size2 = array_length(_skillBoxes_keys)
		for (var k = 0; k < ds_size2; k++) {
			var key = _skillBoxes_keys[k]
			var skillBox = skillBoxes_SERVER[? key]
			ds_map_add(_map_skillBoxes, key, json_stringify(skillBoxes_SERVER[? key]))
		}
		
		// Save - Effect Boxes
		var permanentEffectBoxes_SERVER = global.playerPermanentEffectBoxes_SERVER[? accountID]
		var _list_permanentEffectBoxes = ds_list_create()
		var ds_size2 = ds_list_size(permanentEffectBoxes_SERVER)
		for (var k = 0; k < ds_size2; k++)
			ds_list_add(_list_permanentEffectBoxes, json_stringify(permanentEffectBoxes_SERVER[| k]))
	
		// Write
		ini_open("Boxes.dbfile")
			ini_write_string("Items", accountID, ds_grid_write(_grid_items))
			ini_write_string("Skills", accountID, ds_grid_write(_grid_skills))
			ini_write_string("SkillBoxes", accountID, ds_map_write(_map_skillBoxes))
			ini_write_string("PermanentEffectBoxes", accountID, ds_list_write(_list_permanentEffectBoxes))
		ini_close()
	
		ini_open("Quests.dbfile")
			ini_write_string("Quests", accountID, ds_map_write(_map_quests))
		ini_close()
	
		// Clear
		ds_grid_destroy(_grid_items)
		ds_grid_destroy(_grid_skills)
		ds_map_destroy(_map_quests)
	}
	
	return saveStarted
}