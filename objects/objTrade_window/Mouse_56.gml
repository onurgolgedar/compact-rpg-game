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
			if (global.held_from_assetName == object_get_name(objInventory_window))
				net_client_send(_CODE_SELL, string(global.held_box.item.type)+"|"+string(global.held_box_i)+"|"+string(global.held_box_j)+"|"+box_get_confirmation_number_COMMON(global.held_box), BUFFER_TYPE_STRING)
		}
	}
}

event_inherited()