if (is_mouse_on() and !is_click_blocked()) {	
	for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page; i++) {
		for (var j = 0; j < global.bc_ver_COMMON; j++) {
			var box = ds_grid_get(boxes, i, j)
			
			if (is_mouse_on_box(i, j)) {
				if (box.item != undefined) {
					global.held_box_i = i
					global.held_box_j = j
					global.held_box = box
					global.held_from_assetName = object_get_name(object_index)
					global.held_from = id
				}
			}
		}
	}
	
	if (global.held_box != undefined)
		exit
		
	if (mouseOnButton < pageCount)
		page = mouseOnButton+1
}

event_inherited()