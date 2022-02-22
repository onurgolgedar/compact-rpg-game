function box_get_boxes_string_SERVER(socketID, boxes = undefined) {
	if (boxes = undefined)
		boxes = global.playerBoxes[? db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID)]
				
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