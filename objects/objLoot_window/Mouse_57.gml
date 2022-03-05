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
		
	net_client_send(_CODE_BUY, json_stringify({ type: onBox_box.item.type, i: onBox_i, j: onBox_j, confirmation: box_get_confirmation_number_COMMON(onBox_box), npcID: owner.npcID, target_i: undefined, target_j: undefined, isLoot: 1 }))
	item_delete_COMMON(onBox_box, undefined, onBox_i, onBox_j, 1, boxes)
}