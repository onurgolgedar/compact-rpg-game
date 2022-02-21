event_inherited()

if (clientObject == objWeaponSeller) {
	var priceRatio = 2
	
	boxes  = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
	for (var t = 0; t < global.bc_hor_COMMON*global.pageCount_COMMON; t++)
		for (var z = 0; z < global.bc_ver_COMMON+2; z++)
			ds_grid_set(boxes, t, z, box_create_COMMON())

	ds_grid_set(boxes, 0, 0, {item: get_item_COMMON(SWORD_000), tag: {isActive: false, isForQuest: false}, count: 1})
	ds_grid_set(boxes, 1, 0, {item: get_item_COMMON(SWORD_001), tag: {isActive: false, isForQuest: false}, count: 1})
	
	for (var t = 0; t < global.bc_hor_COMMON*global.pageCount_COMMON; t++)
		for (var z = 0; z < global.bc_ver_COMMON+2; z++) {
			var box = ds_grid_get(boxes, t, z)
			if (box.item != undefined) {
				box.item = item_setup_COMMON(box.item)
				box.item.marketPrice = box.item.worth*priceRatio
			}
		}
}