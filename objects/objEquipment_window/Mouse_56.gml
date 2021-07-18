if (held_box != undefined) {
	if (is_mouse_on()) {
		var mouseOn_box_i = undefined
		var mouseOn_box_j = undefined
		var mouseOn_box = undefined
	
	for (var i = 0; i < global.bc_hor_COMMON; i++) {
		for (var j = global.bc_ver_COMMON; j < global.bc_ver_COMMON+2; j++) {
				if (is_mouse_on_box(i, j)) {
					var box = ds_grid_get(boxes, i, j)
					mouseOn_box = box
					mouseOn_box_i = i
					mouseOn_box_j = j
				}
			}
		}
		
		if (mouseOn_box != undefined) {
			boxes_alpha[held_box_i][held_box_j] = 0
			
			with (objInventory_window)
				inventory_refresh()
		}
	}
}

held_box_i = undefined
held_box_j = undefined
held_box = undefined

event_inherited()