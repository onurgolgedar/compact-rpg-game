if (!isOnExitButton and is_mouse_on() and !is_click_blocked()) {	
	event_perform(ev_other, ev_user0)
	
	if (mouseOnButton == undefined) {
		isHeld = true
		held_offset_x = global.dmx-x
		held_offset_y = global.dmy-y
	}
}