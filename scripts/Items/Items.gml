function item_get_text(item) {
	item_setup_COMMON(item)
	
	if (item.type == ITEMTYPE_SWORD)
		return "[b]"+item.name+" (+"+string(item.upgrade)+")"+"[/b]\nAttack (PHY): "+string(item.physicalPower)+"\nAttack (MAG): "+string(item.magicalPower)+"\nSpeed: "+string(item.attackSpeed)+"\n\n"+string(item.worth)+"[img=sprCoin2]"+strret("\nPrice: "+string(item.marketPrice)+"[img=sprCoin2]", item.marketPrice != undefined)
	else if (item.type == ITEMTYPE_CLOTHES)
		return "[b]"+item.name+" (+"+string(item.upgrade)+")"+"[/b]\nHealth: "+string(item.maxHp)+"\nMana: "+string(item.maxMana)+"\nSlow Rate: "+string(item.slowRate)+"%\n\n"+string(item.worth)+"[img=sprCoin2]"+strret("\nPrice: "+string(item.marketPrice)+"[img=sprCoin2]", item.marketPrice != undefined)
	
	return ""
}

function get_active_box(type) {
	return ds_grid_get(global.boxes, type, global.bc_ver_COMMON)
}

function get_boxes_grid() {				
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

function change_active_box(type, box_i, box_j, box_confirmation_number) {
	var box
	if (box_i != "undefined" and box_i != undefined)
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
	
	var active_box_before = get_active_box(type)
	if (active_box_before == undefined and box == global.boxEmpty_COMMON)
		return false
	
	active_box_before.tag.isActive = false
			
	if (box.item != undefined) {
		ds_grid_set(global.boxes, type, global.bc_ver_COMMON, box)
		box.tag.isActive = true
	}
			
	if (box_i != "undefined" and box_i != undefined)
		ds_grid_set(global.boxes, box_i, box_j, active_box_before)
	else
		unequip_item(active_box_before.item)
			
	with (objInventory_window)
		inventory_refresh()
				
	net_client_send(_CODE_GET_STATISTICS)
				
	return true
}

function change_box_position(box_i, box_j, target_box_i, target_box_j) {	
	var box = ds_grid_get(global.boxes, box_i, box_j)
	var box_target = ds_grid_get(global.boxes, target_box_i, target_box_j)
	
	ds_grid_set(global.boxes, target_box_i, target_box_j, box)
	ds_grid_set(global.boxes, box_i, box_j, box_target)
	
	with (objInventory_window)
		inventory_refresh()
}

function get_active_item(type) {
	return get_active_box(type).item
}

function unequip_item(item) {
	for (var page = 1; page < global.pageCount_COMMON; page++) {
		for (var j = 0; j < global.bc_ver_COMMON; j++) {
			for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page; i++) {
				var box = ds_grid_get(global.boxes, i, j)
				if (box.item == undefined) {
					change_box_position(item.type, global.bc_ver_COMMON, i, j)
					break
				}
			}
		}
	}
}