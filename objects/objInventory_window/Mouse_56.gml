if (held_box != undefined and !is_click_blocked()) {
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
			net_client_send(_CODE_CHANGE_BOX_POSITION, string(held_box_i)+"|"+string(held_box_j)+"|"+string(mouseOn_box_i)+"|"+string(mouseOn_box_j), BUFFER_TYPE_STRING)
			boxes_alpha[held_box_i][held_box_j] = 0
		}
	}
}

held_box_i = undefined
held_box_j = undefined
held_box = undefined

event_inherited()