if (!is_click_blocked() and global.held_box != undefined) {
	if (is_mouse_on()) {
		var mouseOn_box_i = undefined
		var mouseOn_box_j = undefined
		var mouseOn_box = undefined
	
		for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page; i++) {
			for (var j = 0; j < global.bc_ver_COMMON; j++) {
				if (is_mouse_on_box(i, j)) {
					var box = ds_grid_get(boxes, i, j)
					mouseOn_box = box
					mouseOn_box_i = i
					mouseOn_box_j = j
				}
			}
		}
	}
}

event_inherited()