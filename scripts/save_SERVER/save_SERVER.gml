function save_SERVER() {
	db_save_table(global.DB_SRV_TABLE_accounts)
	db_save_table(global.DB_SRV_TABLE_accountInfo)

	var ds_size = db_get_table_size(global.DB_SRV_TABLE_onlineAccounts)
	for (var i = 0; i < ds_size; i++) {
		var _row = db_get_row_by_index(global.DB_SRV_TABLE_onlineAccounts, i)
		var accountID = _row[? ONLINEACCOUNTS_ACCID_SERVER]
	
		// Save - Inventory
		var boxes_SERVER = global.playerBoxes[? accountID]
		var _grid = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
		for (var k = 0; k < global.bc_hor_COMMON*global.pageCount_COMMON; k++) {
			for (var d = 0; d < global.bc_ver_COMMON+2; d++) {
				ds_grid_set(_grid, k, d, json_stringify(ds_grid_get(boxes_SERVER, k, d)))
			}
		}
	
		// Save - Skill Tree
		var boxes_skill_SERVER = global.playerSkills[? accountID]
		var _grid_skills = ds_grid_create(global.sc_hor_COMMON*global.pageCount_skill_COMMON, global.sc_ver_COMMON)
		for (var k = 0; k < global.sc_hor_COMMON*global.pageCount_skill_COMMON; k++) {
			for (var d = 0; d < global.sc_ver_COMMON; d++) {
				ds_grid_set(_grid_skills, k, d, json_stringify(ds_grid_get(boxes_skill_SERVER, k, d)))
			}
		}
	
		// Save - Quests
		var quests_SERVER = global.playerQuests[? accountID]
		var _map_quests = ds_map_create()
		var ds_size2 = ds_map_size(quests_SERVER)
		for (var k = 0; k < ds_size2; k++) {
			var key = ds_map_keys_to_array(quests_SERVER)[k]
			ds_map_set(_map_quests, key, json_stringify(quests_SERVER[? key]))
		}
	
		// Write
		ini_open("Boxes.dbfile")
			ini_write_string("Items", accountID, ds_grid_write(_grid))
			ini_write_string("Skills", accountID, ds_grid_write(_grid_skills))
		ini_close()
	
		ini_open("Quests.dbfile")
			ini_write_string("Quests", accountID, ds_map_write(_map_quests))
		ini_close()
	
		// Clear
		ds_grid_destroy(_grid)
		ds_grid_destroy(_grid_skills)
		ds_map_destroy(_map_quests)
	}
}