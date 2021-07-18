if (is_mouse_on()) {
	isBoxHeld = false
	held_box_i = undefined
	held_box_j = undefined
	held_box = undefined
	
	for (var i = 0; i < global.bc_hor_COMMON; i++) {
		for (var j = global.bc_ver_COMMON; j < global.bc_ver_COMMON+2; j++) {
			var box = ds_grid_get(boxes, i, j)
			
			if (is_mouse_on_box(i, j)) {
				if (box.item != undefined) {
					isBoxHeld = true
					held_box_i = i
					held_box_j = j
					held_box = box
				}
			}
		}
	}
	
	if (isBoxHeld)
		exit
}

event_inherited()