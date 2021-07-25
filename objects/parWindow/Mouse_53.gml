if (is_mouse_on() and !is_click_blocked() and mouseOnButton == undefined) {
	if (isOnExitButton) {
		instance_destroy()
		exit
	}
	
	isHeld = true
	held_offset_x = global.dmx-x
	held_offset_y = global.dmy-y
	
	event_perform(ev_other, ev_user0)
}