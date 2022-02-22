if (global.held_box != undefined) {
	if (is_mouse_on()) {
		if (global.held_from_assetName == object_get_name(objInventory_window)) {
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
		
			if (mouseOn_box != undefined)
				net_client_send(_CODE_box_change_active, string(mouseOn_box_i)+"|"+string(global.held_box_i)+"|"+string(global.held_box_j)+"|"+box_get_confirmation_number_COMMON(global.held_box), BUFFER_TYPE_STRING)
		}
	}
}

event_inherited()