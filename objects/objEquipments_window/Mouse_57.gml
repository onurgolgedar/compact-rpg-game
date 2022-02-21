var onBox = false
var onBox_i = undefined
var onBox_j = undefined
var onBox_box = undefined

if (is_mouse_on() and global.held_box == undefined) {
	for (var i = 0; i < global.bc_hor_COMMON; i++) {
		for (var j = global.bc_ver_COMMON; j < global.bc_ver_COMMON+2; j++) {
			var box = ds_grid_get(boxes, i, j)
			
			if (is_mouse_on_box(i, j)) {
				if (box.item != undefined) {
					onBox = true
					onBox_i = i
					onBox_j = j
					onBox_box = box
					break
				}
			}
		}
	}
	
	if (!onBox)
		exit
		
	net_client_send(_CODE_CHANGE_ACTIVE_BOX, string(onBox_box.item.type)+"|undefined|undefined|"+box_get_confirmation_number_COMMON(onBox_box), BUFFER_TYPE_STRING)
}