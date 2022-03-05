function box_create_COMMON(item = undefined, isForQuest = false, count = 1) {
	if (item == undefined)
		return { item: undefined, tag: { isActive: false, isForQuest: false }, count: 0 }
	else
		return { item: item_copy_COMMON(item), tag: { isActive: false, isForQuest: isForQuest }, count: count }
}

function box_get_confirmation_number_COMMON(box) {
	if (box == undefined)
		return "--"
	else
		return string(box.tag.isActive)+string(box.tag.isForQuest)+string(item_get_confirmation_number_COMMON(box.item))
}

function box_get_active_SERVER(socketID, type) {
	var boxes_SERVER = global.playerBoxes[? db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID)]
	return ds_grid_get(boxes_SERVER, type, global.bc_ver_COMMON)
}

function box_change_active_SERVER(socketID, type, box_i, box_j, box_confirmation_number) {
	var boxes_SERVER = global.playerBoxes[? db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID)]
	
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
	active_box_before.tag.isActive = false
			
	if (box.item != undefined) {
		ds_grid_set(boxes_SERVER, type, global.bc_ver_COMMON, box)
		box.tag.isActive = true
	}
			
	if (box_i != undefined and box_i != undefined)
		ds_grid_set(boxes_SERVER, box_i, box_j, active_box_before)
	else
		item_unequip_SERVER(socketID, boxes_SERVER, active_box_before.item)
				
	result = box
	
	var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID, PLAYERS_INSTANCE_SERVER)
	if (instance != undefined and instance_exists(instance))
		with (instance)
			player_recalculate_statistics_SERVER()
	
	return result
}

function box_change_position_SERVER(socketID, box_i, box_j, target_box_i, target_box_j) {
	var boxes_SERVER = global.playerBoxes[? db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID)]
	
	var box = ds_grid_get(boxes_SERVER, box_i, box_j)
	var box_target = ds_grid_get(boxes_SERVER, target_box_i, target_box_j)
	
	ds_grid_set(boxes_SERVER, target_box_i, target_box_j, box)
	ds_grid_set(boxes_SERVER, box_i, box_j, box_target)
	
	return true
}