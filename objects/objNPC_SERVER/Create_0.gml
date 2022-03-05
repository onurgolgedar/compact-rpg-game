event_inherited()

if (clientObject == objWeaponSeller) {
	var priceRatio = 2
	
	boxes  = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
	for (var t = 0; t < global.bc_hor_COMMON*global.pageCount_COMMON; t++)
		for (var z = 0; z < global.bc_ver_COMMON+2; z++)
			ds_grid_set(boxes, t, z, box_create_COMMON())

	// Item List
	ds_grid_set(boxes, 0, 0, box_create_COMMON(item_get_COMMON(SWORD_000)))
	ds_grid_set(boxes, 1, 0, box_create_COMMON(item_get_COMMON(SWORD_001)))
	ds_grid_set(boxes, 2, 0, box_create_COMMON(item_get_COMMON(SWORD_002)))
	ds_grid_set(boxes, 3, 0, box_create_COMMON(item_get_COMMON(SWORD_003)))
	ds_grid_set(boxes, 0, 1, box_create_COMMON(item_get_COMMON(CLOTHES_000)))
	ds_grid_set(boxes, 1, 1, box_create_COMMON(item_get_COMMON(CLOTHES_001)))
	ds_grid_set(boxes, 2, 1, box_create_COMMON(item_get_COMMON(CLOTHES_002)))
	ds_grid_set(boxes, 3, 1, box_create_COMMON(item_get_COMMON(CLOTHES_003)))
	ds_grid_set(boxes, 0+global.bc_hor_COMMON, 0, box_create_COMMON(item_get_COMMON(SWORD_000X)))
	ds_grid_set(boxes, 1+global.bc_hor_COMMON, 0, box_create_COMMON(item_get_COMMON(SWORD_001X)))
	ds_grid_set(boxes, 2+global.bc_hor_COMMON, 0, box_create_COMMON(item_get_COMMON(SWORD_002X)))
	ds_grid_set(boxes, 3+global.bc_hor_COMMON, 0, box_create_COMMON(item_get_COMMON(SWORD_003X)))
	ds_grid_set(boxes, 0+global.bc_hor_COMMON, 1, box_create_COMMON(item_get_COMMON(CLOTHES_000X)))
	ds_grid_set(boxes, 1+global.bc_hor_COMMON, 1, box_create_COMMON(item_get_COMMON(CLOTHES_001X)))
	ds_grid_set(boxes, 2+global.bc_hor_COMMON, 1, box_create_COMMON(item_get_COMMON(CLOTHES_002X)))
	ds_grid_set(boxes, 3+global.bc_hor_COMMON, 1, box_create_COMMON(item_get_COMMON(CLOTHES_003X)))
	ds_grid_set(boxes, 0+global.bc_hor_COMMON*2, 0, box_create_COMMON(item_get_COMMON(VALUABLE_000)))
	
	for (var t = 0; t < global.bc_hor_COMMON*global.pageCount_COMMON; t++) {
		for (var z = 0; z < global.bc_ver_COMMON+2; z++) {
			var box = ds_grid_get(boxes, t, z)
			if (box.item != undefined) {
				item_setup_COMMON(box.item)
				box.tag.marketPrice = box.item.worth*priceRatio
			}
		}
	}
	
	/*lootBoxes  = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
	for (var t = 0; t < global.bc_hor_COMMON*global.pageCount_COMMON; t++)
		for (var z = 0; z < global.bc_ver_COMMON+2; z++)
			ds_grid_set(lootBoxes, t, z, box_create_COMMON())

	ds_grid_set(lootBoxes, 0, 0, {item: item_get_COMMON(SWORD_000), tag: {isActive: false, isForQuest: false}, count: 1})
	ds_grid_set(lootBoxes, 1, 0, {item: item_get_COMMON(SWORD_001), tag: {isActive: false, isForQuest: false}, count: 1})
	ds_grid_set(lootBoxes, 0, 1, {item: item_get_COMMON(VALUABLE_000), tag: {isActive: false, isForQuest: false}, count: 1})
	
	for (var t = 0; t < global.bc_hor_COMMON*global.pageCount_COMMON; t++) {
		for (var z = 0; z < global.bc_ver_COMMON+2; z++) {
			var box = ds_grid_get(lootBoxes, t, z)
			if (box.item != undefined)
				item_setup_COMMON(box.item)
		}
	}*/
}