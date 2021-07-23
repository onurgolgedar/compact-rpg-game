if (is_mouse_on() and global.held_box == undefined) {	
	for (var i = 0; i < global.bc_hor_COMMON; i++) {
		for (var j = global.bc_ver_COMMON; j < global.bc_ver_COMMON+2; j++) {
			var box = ds_grid_get(boxes, i, j)
			
			if (is_mouse_on_box(i, j)) {
				if (box.item != undefined) {
					global.held_box_i = i
					global.held_box_j = j
					global.held_from = object_get_name(object_index)
					global.held_box = box
				}
			}
		}
	}
	
	if (global.held_box != undefined)
		exit
}

event_inherited()