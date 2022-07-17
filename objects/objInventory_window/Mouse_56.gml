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
		
		if (global.held_from_assetName == object_get_name(objEquipments_window)) {
			if (mouseOn_box != undefined)
				net_client_send(_CODE_BOX_CHANGE_ACTIVE, json_stringify({ type: global.held_box.item.type, i: mouseOn_box_i, j: mouseOn_box_j, confirmation: box_get_confirmation_number_COMMON(mouseOn_box) }), BUFFER_TYPE_STRING)
		}
		else if (global.held_from_assetName == object_get_name(objinventory_window)) {
			if (mouseOn_box != undefined) {
				net_client_send(_CODE_BOX_CHANGE_POSITION, json_stringify({ i: global.held_box_i, j: global.held_box_j, target_i: mouseOn_box_i, target_j: mouseOn_box_j }), BUFFER_TYPE_STRING)
				boxes_alpha[global.held_box_i][global.held_box_j] = 0
			}
		}
		else if (global.held_from_assetName == object_get_name(objTrade_window)) {
			if (mouseOn_box != undefined)
				net_client_send(_CODE_BUY, json_stringify({ type: global.held_box.item.type, i: global.held_box_i, j: global.held_box_j, confirmation: box_get_confirmation_number_COMMON(global.held_box), npcID: global.held_from.owner.npcID, target_i: mouseOn_box_i, target_j: mouseOn_box_j, isLoot: 0 }), BUFFER_TYPE_STRING)
			else
				net_client_send(_CODE_BUY,json_stringify({ type: global.held_box.item.type, i: global.held_box_i, j: global.held_box_j, confirmation: box_get_confirmation_number_COMMON(global.held_box), npcID: global.held_from.owner.npcID, target_i: undefined, target_j: undefined, isLoot: 0 }), BUFFER_TYPE_STRING)
		}
		else if (global.held_from_assetName == object_get_name(objLoot_window)) {
			if (mouseOn_box != undefined)
				net_client_send(_CODE_BUY, json_stringify({ type: global.held_box.item.type, i: global.held_box_i, j: global.held_box_j, confirmation: box_get_confirmation_number_COMMON(global.held_box), npcID: global.held_from.owner.npcID, target_i: mouseOn_box_i, target_j: mouseOn_box_j, isLoot: 0 }), BUFFER_TYPE_STRING)
			else
				net_client_send(_CODE_BUY, json_stringify({ type: global.held_box.item.type, i: global.held_box_i, j: global.held_box_j, confirmation: box_get_confirmation_number_COMMON(global.held_box), npcID: global.held_from.owner.npcID, target_i: undefined, target_j: undefined, isLoot: 0 }), BUFFER_TYPE_STRING)
			
			item_delete_COMMON(global.held_box, undefined, global.held_box_i, global.held_box_j, 1, global.held_from.boxes)
		}
	}
}

event_inherited()