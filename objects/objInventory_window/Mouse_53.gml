if (is_mouse_on() and !is_click_blocked()) {
	isBoxHeld = false
	held_box_i = undefined
	held_box_j = undefined
	held_box = undefined
	
	for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page; i++) {
		for (var j = 0; j < global.bc_ver_COMMON; j++) {
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
		
	if (mouseOnButton < pageCount)
		page = mouseOnButton+1
		
	if (mouseOnButton == 100) {
		if (!instance_exists(objEquipment_window))
			instance_create_layer(x+width+boxWidth, y, "Windows", objEquipment_window)
		else
			instance_destroy(objEquipment_window)
	}
}

event_inherited()