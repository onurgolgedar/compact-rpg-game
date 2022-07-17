function item_get_text(item, marketPrice = undefined) {
	item_setup_COMMON(item)
	
	switch (item.type) {
		case ITEMTYPE_SWORD:
			return item_get_title_COMMON(item)+"\nAttack (PHY): "+string(item.physicalPower)+"\nAttack (MAG): "+string(item.magicalPower)+"\nSpeed: "+string(item.attackSpeed)+"\n\n"+string(item.worth)+"[img=sprCoin2]"+strret("\nPrice: "+string(marketPrice)+"[img=sprCoin2]", marketPrice != undefined)
		
		case ITEMTYPE_CLOTHES:
			return item_get_title_COMMON(item)+"\nHealth: "+string(item.maxHp)+"\nMana: "+string(item.maxMana)+"\nSlow Rate: "+string(item.slowRate)+"%\n\n"+string(item.worth)+"[img=sprCoin2]"+strret("\nPrice: "+string(marketPrice)+"[img=sprCoin2]", marketPrice != undefined)
		
		case ITEMTYPE_VALUABLE:
			return item_get_title_COMMON(item)+"\n\n"+string(item.worth)+"[img=sprCoin2]"+strret("\nPrice: "+string(marketPrice)+"[img=sprCoin2]", marketPrice != undefined)
	}
	
	return ""
}

function box_get_active(type) {
	return ds_grid_get(global.boxes, type, global.bc_ver_COMMON)
}

function box_get_boxes_string() {				
	var _grid = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
	for (var k = 0; k < global.bc_hor_COMMON*global.pageCount_COMMON; k++) {
		for (var z = 0; z < global.bc_ver_COMMON+2; z++) {
			var box = ds_grid_get(global.boxes, k, z)
		
			ds_grid_set(_grid, k, z, json_stringify(box))
		}
	}

	var grid_string = ds_grid_write(_grid)
	ds_grid_destroy(_grid)
	
	return grid_string
}

function box_change_active(type, box_i, box_j, box_confirmation_number) {
	var box
	if (box_i != undefined)
		box = ds_grid_get(global.boxes, box_i, box_j)
	else
		box = box_create_COMMON()
		
	if (box.item != undefined) {
		if (box.item.type != type)
			return false
		
		item_setup_COMMON(box.item)
		if (box_get_confirmation_number_COMMON(box) != box_confirmation_number)
			return false
	}
	
	var active_box_before = box_get_active(type)
	if (active_box_before == undefined and box == global.boxEmpty_COMMON)
		return false
			
	if (box_i != undefined) {
		ds_grid_set(global.boxes, type, global.bc_ver_COMMON, box)
		ds_grid_set(global.boxes, box_i, box_j, active_box_before)
	}
	else
		unequip_item(active_box_before.item)
			
	with (objinventory_window)
		inventory_refresh()
				
	net_client_send(_CODE_GET_STATISTICS)
				
	return true
}

function box_change_position(box_i, box_j, target_box_i, target_box_j) {	
	var box = ds_grid_get(global.boxes, box_i, box_j)
	var box_target = ds_grid_get(global.boxes, target_box_i, target_box_j)
	
	ds_grid_set(global.boxes, target_box_i, target_box_j, box)
	ds_grid_set(global.boxes, box_i, box_j, box_target)
	
	with (objinventory_window)
		inventory_refresh()
}

function get_active_item(type) {
	return box_get_active(type).item
}

function unequip_item(item) {
	for (var page = 1; page < global.pageCount_COMMON; page++) {
		for (var j = 0; j < global.bc_ver_COMMON; j++) {
			for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page; i++) {
				var box = ds_grid_get(global.boxes, i, j)
				if (box.item == undefined) {
					box_change_position(item.type, global.bc_ver_COMMON, i, j)
					break
				}
			}
		}
	}
}