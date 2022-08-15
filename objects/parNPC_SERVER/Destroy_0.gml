if (boxes != undefined) {
	for (var t = 0; t < global.bc_hor_COMMON*global.pageCount_COMMON; t++)
		for (var z = 0; z < global.bc_ver_COMMON+2; z++) {
			var struct = ds_grid_get(boxes, t, z)
			if (is_struct(struct))
				delete struct
		}
		
	ds_grid_destroy(boxes)
}
if (lootBoxes != undefined) {
	for (var t = 0; t < global.bc_hor_COMMON*global.pageCount_COMMON; t++)
		for (var z = 0; z < global.bc_ver_COMMON+2; z++) {
			var struct = ds_grid_get(lootBoxes, t, z)
			if (is_struct(struct))
				delete struct
		}
		
	ds_grid_destroy(lootBoxes)
}