function cleanup_player_ds_SERVER(accID) {
	if (global.playerBoxes_SERVER[? accID] != undefined) {
		var ds = global.playerBoxes_SERVER[? accID]
		if (ds_exists(ds, ds_type_grid)) //
			ds_grid_destroy(ds)
						
		global.playerBoxes_SERVER[? accID] = undefined
		ds_map_delete(global.playerBoxes_SERVER, accID)
	}
					
	if (global.playerSkills_SERVER[? accID] != undefined) {
		var ds = global.playerSkills_SERVER[? accID]
		if (ds_exists(ds, ds_type_grid))
			ds_grid_destroy(ds)
						
		global.playerSkills_SERVER[? accID] = undefined
		ds_map_delete(global.playerSkills_SERVER, accID)
	}
					
	if (global.playerQuests_SERVER[? accID] != undefined) {
		var ds = global.playerQuests_SERVER[? accID]
		if (ds_exists(ds, ds_type_map))
			ds_map_destroy(ds)
						
		global.playerQuests_SERVER[? accID] = undefined
		ds_map_delete(global.playerQuests_SERVER, accID)
	}
				
	if (global.playerPermanentEffectBoxes_SERVER[? accID] != undefined) {
		var ds = global.playerPermanentEffectBoxes_SERVER[? accID]
		if (ds_exists(ds, ds_type_list))
			ds_list_destroy(ds)
						
		global.playerPermanentEffectBoxes_SERVER[? accID] = undefined
		ds_map_delete(global.playerPermanentEffectBoxes_SERVER, accID)
	}
					
	if (global.playerSkillBoxes_SERVER[? accID] != undefined) {
		var ds = global.playerSkillBoxes_SERVER[? accID]
		if (ds_exists(ds, ds_type_map))
			ds_map_destroy(ds)
						
		global.playerSkillBoxes_SERVER[? accID] = undefined
		ds_map_delete(global.playerSkillBoxes_SERVER, accID)
	}
}