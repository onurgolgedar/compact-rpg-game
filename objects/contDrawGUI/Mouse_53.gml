with (contGameController) {
	if (!is_mouse_on_any_window()) {
		if (other.mouseOnBLogo)
			event_perform(ev_keypress, ord("I"))
		else if (other.mouseOnCLogo)
			event_perform(ev_keypress, ord("C"))
		else if (other.mouseOnQLogo)
			event_perform(ev_keypress, ord("J"))
		else if (other.mouseOnSLogo)
			event_perform(ev_keypress, ord("Y"))
			
		if (other.mouseOnSkillBox != undefined and is_alive() and objPlayer.skills[other.mouseOnSkillBox].index != undefined) {
			global.held_box_i = other.mouseOnSkillBox
			global.held_box_j = 0
			global.held_box = objPlayer.skills[other.mouseOnSkillBox]
			global.held_from_assetName = object_get_name(other.object_index)
		}
	}
}