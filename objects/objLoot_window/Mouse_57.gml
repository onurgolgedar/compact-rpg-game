var onBox = false
var onBox_i = undefined
var onBox_j = undefined
var onBox_box = undefined

if (is_mouse_on() and !is_click_blocked()) {
	for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page and !onBox; i++) {
		for (var j = 0; j < global.bc_ver_COMMON; j++) {
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
		
	net_client_send(_CODE_BUY, string(onBox_box.item.type)+"|"+string(onBox_i)+"|"+string(onBox_j)+"|"+box_get_confirmation_number_COMMON(onBox_box)+"|"+string(owner.npcID)+"|undefined|undefined|1", BUFFER_TYPE_STRING)
	item_delete_COMMON(onBox_box, undefined, onBox_i, onBox_j, 1, boxes)
}