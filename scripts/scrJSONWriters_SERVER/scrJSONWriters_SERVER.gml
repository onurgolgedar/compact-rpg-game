function json_write_boxes_SERVER(socketID, boxes = undefined) {
	if (boxes = undefined)
		boxes = global.playerBoxes[? db_find_value(global.DB_SRV_TABLE_players, PLAYERS_ACCID_SERVER, PLAYERS_SOCKETID_SERVER, socketID)]
				
	var _grid = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
	for (var k = 0; k < global.bc_hor_COMMON*global.pageCount_COMMON; k++) {
		for (var z = 0; z < global.bc_ver_COMMON+2; z++) {
			var box = ds_grid_get(boxes, k, z)
		
			ds_grid_set(_grid, k, z, json_stringify(box))
		}
	}

	var grid_string = ds_grid_write(_grid)
	ds_grid_destroy(_grid)
	
	return grid_string
}

function json_write_skillboxes_SERVER(socketID) {
	var boxes_skill_SERVER = global.playerSkills[? db_find_value(global.DB_SRV_TABLE_players, PLAYERS_ACCID_SERVER, PLAYERS_SOCKETID_SERVER, socketID)]
				
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

/*function json_write_permanentEffectBoxes_SERVER(socketID) {
	var permanentEffectBoxes_SERVER = global.playerPermanentEffectBoxes[? db_find_value(global.DB_SRV_TABLE_players, PLAYERS_ACCID_SERVER, PLAYERS_SOCKETID_SERVER, socketID)]
				
	var _list = ds_list_create()
	var ds_size = ds_list_size(permanentEffectBoxes_SERVER)
	for (var i = 0; i < ds_size; i++)
		ds_list_add(_list, json_stringify(ds_list_find_value(permanentEffectBoxes_SERVER, i)))

	var grid_string = ds_list_write(_list)
	ds_list_destroy(_list)
	
	return grid_string
}*/
