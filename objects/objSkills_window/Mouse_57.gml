var onBox = false
var onBox_i = undefined
var onBox_j = undefined
var onBox_box = undefined

if (is_mouse_on() and !is_click_blocked()) {
	for (var i = global.sc_hor_COMMON*(page-1); i < global.sc_hor_COMMON*page and !onBox; i++) {
		for (var j = 0; j < global.sc_ver_COMMON; j++) {
			var box = ds_grid_get(boxes, i, j)
			
			if (is_mouse_on_box(i, j)) {
				if (box.skill != undefined) {
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
		
	with (objPlayer) {
		for (var i = 0; i < 5; i++) {
			if (skills[i].index == onBox_box.skill.index)
				break
			else if (skills[i].index == undefined) {
				net_client_send(_CODE_SET_SKILLBOX, string(i)+"|"+string(onBox_box.skill.index)+"|-1", BUFFER_TYPE_STRING)
				break
			}
		}
	}
}