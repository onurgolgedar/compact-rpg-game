function item_add_SERVER(box, accountID, box_i = undefined, box_j = undefined, count = 1, boxes = undefined) {
	if (boxes == undefined)
		boxes = global.playerBoxes_SERVER[? accountID]
	
	var sameItem_box = item_get_exists_SERVER(box, accountID, boxes)

	if (!box.item.isCollectable or sameItem_box == undefined) {
		if (count != 1)
			return false
		
		if (box_i == undefined) {
			for (var pageScanning = 1; pageScanning <= global.pageCount_COMMON; pageScanning++)
			    for (var j = 0; j < global.bc_ver_COMMON; j++) {
			        for (var i = global.bc_hor_COMMON*(pageScanning-1); i < global.bc_hor_COMMON*pageScanning; i++) {
						var _box = ds_grid_get(boxes, i, j)
				
						if (_box.item == undefined) {
							_box.item = item_copy_COMMON(box.item)
							_box.count += count
							return { result: true, i: i, j: j }
						}
					}
				}
		}
		else {
			var _box = ds_grid_get(boxes, box_i, box_j)
			if (_box.item == undefined) {
				_box.item = item_copy_COMMON(box.item)
				_box.count += count
				return { result: true, i: box_i, j: box_j }
			}
			
			return item_add_SERVER(box, accountID, undefined, undefined, count, boxes)
		}
	}
	else if (sameItem_box != undefined) {
		ds_grid_get(boxes, sameItem_box.i, sameItem_box.j).count += count
		return { result: true, i: sameItem_box.i, j: sameItem_box.j }
	}
	
	return { result: false, i: undefined, j: undefined }
}

function item_get_exists_SERVER(box, accountID = undefined, boxes = undefined) {
	if (boxes == undefined)
		boxes = global.playerBoxes_SERVER[? accountID]
	
	for (var j = 0; j < global.bc_ver_COMMON; j++)
	    for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
			var _box = ds_grid_get(boxes, i, j)
			
	        if (_box.item != undefined and box_get_confirmation_number_COMMON(_box) == box_get_confirmation_number_COMMON(box))
	            return { i: i, j: j }
		}
                
	return undefined
}

function item_get_active_SERVER(socketID, type) {
	return box_get_active_SERVER(socketID, type).item
}

function item_unequip_SERVER(socketID, boxes, item) {
	for (var page = 1; page < global.pageCount_COMMON; page++) {
		for (var j = 0; j < global.bc_ver_COMMON; j++) {
			for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page; i++) {
				var box = ds_grid_get(boxes, i, j)
				if (box.item == undefined) {
					box_change_position_SERVER(socketID, item.type, global.bc_ver_COMMON, i, j)
					return true
				}
			}
		}	
	}
	
	return false
}