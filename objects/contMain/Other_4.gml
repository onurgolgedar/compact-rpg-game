if (room != roomMenu) {
	if (global.boxes == undefined) {
		global.gold = 0
		global.boxes = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
		for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++)
			for (var j = 0; j < global.bc_ver_COMMON+2; j++)
				ds_grid_set(global.boxes, i, j, box_create_COMMON())
	}
	
	if (global.boxes_skill == undefined) {
		global.boxes_skill = ds_grid_create(global.sc_hor_COMMON*global.pageCount_skill_COMMON, global.sc_ver_COMMON)
		for (var i = 0; i < global.sc_hor_COMMON*global.pageCount_skill_COMMON; i++)
			for (var j = 0; j < global.sc_ver_COMMON; j++)
				ds_grid_set(global.boxes_skill, i, j, global.boxEmpty_skill_COMMON)
	}
}