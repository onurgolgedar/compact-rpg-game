function add_item_SERVER(item, accountID, box_i = undefined, box_j = undefined, count = 1) {
	var boxes = global.playerBoxes[? accountID]
	
	var pageScanning = 1
	var sameItem = item_get_exists_SERVER(item, accountID) == undefined

	if (!item.isCollectable or sameItem == undefined) {
		if (box_i == undefined) {
		    for (var j = 0; j < global.bc_ver_COMMON; j++) {
		        for (var i = global.bc_hor_COMMON*(pageScanning-1); i < global.bc_hor_COMMON*pageScanning; i++) {
					var box = ds_grid_get(boxes, i, j)
				
					if (box.item == undefined) {
						box.item = item_copy_COMMON(item)
						return true
					}
				}
			}
		}
		else {
			var box = ds_grid_get(boxes, box_i, box_j)
			if (box.item == undefined) {
				box.item = item_copy_COMMON(item)
				return true
			}
		}
	}
	else if (sameItem != undefined) {
		sameItem.count += count
		return true
	}
	
	return false
}

function item_get_exists_SERVER(item, accountID) {
	var boxes = global.playerBoxes[? accountID]
	
	for (var j = 0; j < global.bc_ver_COMMON; j++)
	    for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
			var box = ds_grid_get(boxes, i, j)
			
	        if (box.item != -1 and box.item == item)
	            return {i: i, j: j}
		}
                
	return undefined
}