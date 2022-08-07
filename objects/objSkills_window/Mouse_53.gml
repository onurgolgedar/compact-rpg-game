if (is_mouse_on() and !is_click_blocked()) {	
	for (var i = global.sc_hor_COMMON*(page-1); i < global.sc_hor_COMMON*page; i++) {
		for (var j = 0; j < global.sc_ver_COMMON; j++) {
			var box = ds_grid_get(boxes, i, j)
			
			if (is_mouse_on_box(i, j)) {
				if (box.skill != undefined) {
					global.held_box_i = i
					global.held_box_j = j
					global.held_box = box
					global.held_from_assetName = object_get_name(object_index)
					global.held_from = id
				}
			}
		}
	}
	
	if (global.held_box != undefined) {
		event_inherited()
		exit
	}
		
	if (mouseOnButton < pageCount) {
		page = mouseOnButton+1
		audio_play_sound(sndMenuTick, 1, 0)
	}
	else {
		if (mouseOnButton >= 2000000) {
			var ii = floor(mouseOnButton-2000000)
			var jj = round((mouseOnButton-2000000-ii)*100)
			net_client_send(_CODE_UPGRADE_SKILL, json_stringify({ ii: ii, jj: jj, upgrade: false }), BUFFER_TYPE_STRING)
			var box = ds_grid_get(boxes, ii, jj)
			box.skill.upgrade--
			global.skillPoints++
			audio_play_sound(sndMenuTick, 1, 0)
		}
		else if (mouseOnButton >= 1000000) {
			var ii = floor(mouseOnButton-1000000)
			var jj = round((mouseOnButton-1000000-ii)*100)
			net_client_send(_CODE_UPGRADE_SKILL, json_stringify({ ii: ii, jj: jj, upgrade: true }), BUFFER_TYPE_STRING)
			var box = ds_grid_get(boxes, ii, jj)
			box.skill.upgrade++
			global.skillPoints--
			audio_play_sound(sndMenuTick, 1, 0)
		}
	}
}

event_inherited()