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
		
		if (mouseOn_box != undefined) {
			if (global.held_from == object_get_name(objEquipments_window))
				net_client_send(_CODE_CHANGE_ACTIVE_BOX, string(global.held_box.item.type)+"|"+string(mouseOn_box_i)+"|"+string(mouseOn_box_j)+"|"+get_box_confirmation_number_COMMON(mouseOn_box), BUFFER_TYPE_STRING)
			else if (global.held_from == object_get_name(objInventory_window)) {
				net_client_send(_CODE_CHANGE_BOX_POSITION, string(global.held_box_i)+"|"+string(global.held_box_j)+"|"+string(mouseOn_box_i)+"|"+string(mouseOn_box_j), BUFFER_TYPE_STRING)
				boxes_alpha[global.held_box_i][global.held_box_j] = 0
			}
		}
	}
}

event_inherited()