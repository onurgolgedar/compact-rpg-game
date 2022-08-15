function box_get_active_SERVER(socketID, type) {
	var boxes_SERVER = global.playerBoxes_SERVER[? db_find_value(global.DB_SRV_TABLE_players, PLAYERS_ACCID_SERVER, PLAYERS_SOCKETID_SERVER, socketID)]
	return ds_grid_get(boxes_SERVER, type, global.bc_ver_COMMON)
}

function box_change_active_SERVER(socketID, type, box_i, box_j, box_confirmation_number) {
	var boxes_SERVER = global.playerBoxes_SERVER[? db_find_value(global.DB_SRV_TABLE_players, PLAYERS_ACCID_SERVER, PLAYERS_SOCKETID_SERVER, socketID)]
	
	var box
	if (box_i != undefined and box_i != undefined)
		box = ds_grid_get(boxes_SERVER, box_i, box_j)
	else
		box = box_create_COMMON()
	
	if (box.item != undefined) {
		if (box.item.type != type)
			return -1
			
		if (box.item.type != ITEMTYPE_CLOTHES and box.item.type != ITEMTYPE_SWORD)
			return -1
		
		item_setup_COMMON(box.item)
		if (box_get_confirmation_number_COMMON(box) != box_confirmation_number)
			return -1
	}
	
	var active_box_before = box_get_active_SERVER(socketID, type)
	if (active_box_before == undefined and box == global.boxEmpty_COMMON)
		return -1
	
	var result = -1
			
	if (box_i != undefined and box_j != undefined) {
		ds_grid_set(boxes_SERVER, box_i, box_j, active_box_before)
		ds_grid_set(boxes_SERVER, type, global.bc_ver_COMMON, box)
	}
	else
		item_unequip_SERVER(socketID, boxes_SERVER, active_box_before.item)
				
	result = box
	
	var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID, PLAYERS_INSTANCE_SERVER)
	if (instance != undefined and instance_exists(instance))
		with (instance)
			player_recalculate_statistics_SERVER()
	
	return result
}

function box_change_position_SERVER(socketID, box_i, box_j, target_box_i, target_box_j, boxes_SERVER = undefined) {
	if (boxes_SERVER == undefined)
		boxes_SERVER = global.playerBoxes_SERVER[? db_find_value(global.DB_SRV_TABLE_players, PLAYERS_ACCID_SERVER, PLAYERS_SOCKETID_SERVER, socketID)]
	
	var box = ds_grid_get(boxes_SERVER, box_i, box_j)
	var box_target = ds_grid_get(boxes_SERVER, target_box_i, target_box_j)
	
	ds_grid_set(boxes_SERVER, target_box_i, target_box_j, box)
	ds_grid_set(boxes_SERVER, box_i, box_j, box_target)
	
	return true
}