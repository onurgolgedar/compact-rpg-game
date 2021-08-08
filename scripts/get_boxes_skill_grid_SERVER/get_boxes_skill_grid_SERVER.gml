function get_boxes_skill_grid_SERVER(socketID) {
	var boxes_skill_SERVER = global.playerSkills[? db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID)]
				
	var _grid = ds_grid_create(global.sc_hor_COMMON*global.pageCount_skill_COMMON, global.sc_ver_COMMON)
	for (var k = 0; k < global.sc_hor_COMMON*global.pageCount_skill_COMMON; k++) {
		for (var z = 0; z < global.sc_ver_COMMON; z++) {
			var box = ds_grid_get(boxes_skill_SERVER, k, z)
		
			ds_grid_set(_grid, k, z, json_stringify(box))
		}
	}

	var grid_string = ds_grid_write(_grid)
	ds_grid_destroy(_grid)
	
	return grid_string
}