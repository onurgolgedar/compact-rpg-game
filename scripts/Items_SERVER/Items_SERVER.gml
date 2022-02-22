function item_add_SERVER(box, accountID, box_i = undefined, box_j = undefined, count = 1, boxes = undefined) {
	if (boxes == undefined)
		boxes = global.playerBoxes[? accountID]
	
	var pageScanning = 1
	var sameItem_box = item_get_exists_SERVER(box, accountID, boxes)

	if (!box.item.isCollectable or sameItem_box == undefined) {
		if (count != 1)
			return false
		
		if (box_i == undefined) {
		    for (var j = 0; j < global.bc_ver_COMMON; j++) {
		        for (var i = global.bc_hor_COMMON*(pageScanning-1); i < global.bc_hor_COMMON*pageScanning; i++) {
					var _box = ds_grid_get(boxes, i, j)
				
					if (_box.item == undefined) {
						_box.item = item_copy_COMMON(box.item)
						_box.count += count
						return { result: true, i: i, j: j }
					}
				}
			}
		}
		else {
			var _box = ds_grid_get(boxes, box_i, box_j)
			if (_box.item == undefined) {
				_box.item = item_copy_COMMON(box.item)
				_box.count += count
				return { result: true, i: box_i, j: box_j }
			}
			
			return item_add_SERVER(box.item, accountID, undefined, undefined, count, boxes)
		}
	}
	else if (sameItem_box != undefined) {
		ds_grid_get(boxes, sameItem_box.i, sameItem_box.j).count += count
		return { result: true, i: sameItem_box.i, j: sameItem_box.j }
	}
	
	return { result: false, i: undefined, j: undefined }
}

function item_get_exists_SERVER(box, accountID = undefined, boxes = undefined) {
	if (boxes == undefined)
		boxes = global.playerBoxes[? accountID]
	
	for (var j = 0; j < global.bc_ver_COMMON; j++)
	    for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
			var _box = ds_grid_get(boxes, i, j)
			
	        if (_box.item != undefined and box_get_confirmation_number_COMMON(_box) == box_get_confirmation_number_COMMON(box))
	            return {i: i, j: j}
		}
                
	return undefined
}

function box_get_active_SERVER(socketID, type) {
	var boxes_SERVER = global.playerBoxes[? db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID)]
	return ds_grid_get(boxes_SERVER, type, global.bc_ver_COMMON)
}

function box_change_active_SERVER(socketID, type, box_i, box_j, box_confirmation_number) {
	var boxes_SERVER = global.playerBoxes[? db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID)]
	
	var box
	if (box_i != "undefined" and box_i != undefined)
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
			
	if (box_i != "undefined" and box_i != undefined)
		ds_grid_set(boxes_SERVER, box_i, box_j, active_box_before)
	else
		item_unequip_SERVER(socketID, boxes_SERVER, active_box_before.item)
				
	result = box
	
	var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID, PLAYERS_INSTANCE_SERVER)
	if (instance != undefined and instance_exists(instance))
		with (instance)
			recalculate_character_statistics_SERVER()
	
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

function item_get_active_SERVER(socketID, type) {
	return box_get_active_SERVER(socketID, type).item
}

function item_unequip_SERVER(socketID, boxes, item) {
	for (var page = 1; page < global.pageCount_COMMON; page++) {
		for (var j = 0; j < global.bc_ver_COMMON; j++) {
			for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page; i++) {
				var box = ds_grid_get(boxes, i, j)
				if (box.item == undefined) {
					box_change_position_SERVER(socketID, item.type, global.bc_ver_COMMON, i, j)
					return true
				}
			}
		}	
	}
	
	return false
}